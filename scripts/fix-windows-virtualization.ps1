# Run as Administrator: Right-click PowerShell -> Run as administrator
# Then: Set-ExecutionPolicy Bypass -Scope Process -Force; & "D:\SWST41062-Group-Project\ecommerce-product-service\scripts\fix-windows-virtualization.ps1"

$ErrorActionPreference = "Stop"

Write-Host "=== 1. Enable required Windows features ===" -ForegroundColor Cyan
$features = @(
    "Microsoft-Windows-Subsystem-Linux",
    "VirtualMachinePlatform",
    "HypervisorPlatform"
)
foreach ($f in $features) {
    Write-Host "Enabling $f ..."
    dism /online /enable-feature /featurename:$f /all /norestart
}

Write-Host "`n=== 2. BCDEdit hypervisor launch ===" -ForegroundColor Cyan
bcdedit /set hypervisorlaunchtype auto
bcdedit /enum | Select-String -Pattern "hypervisor"

Write-Host "`n=== 3. Disable Memory Integrity (HVCI) - reduces VBS/Docker conflict ===" -ForegroundColor Cyan
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" `
    -Name "Enabled" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" `
    -Name "EnableVirtualizationBasedSecurity" -Value 0 -Type DWord -Force

Write-Host "`n=== 4. Add Docker to User PATH ===" -ForegroundColor Cyan
$dockerBin = "C:\Program Files\Docker\Docker\resources\bin"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$dockerBin*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$dockerBin", "User")
    Write-Host "Added Docker to User PATH"
}

Write-Host "`n=== 5. Feature verification ===" -ForegroundColor Cyan
foreach ($f in $features) {
    dism /online /get-featureinfo /featurename:$f | Select-String "Feature Name|State"
}

Write-Host "`n=== 6. Firmware / hypervisor WMI ===" -ForegroundColor Cyan
Write-Host "VirtualizationFirmwareEnabled: $((Get-CimInstance Win32_Processor).VirtualizationFirmwareEnabled)"
Write-Host "HypervisorPresent: $((Get-CimInstance Win32_ComputerSystem).HypervisorPresent)"

Write-Host "`n=== DONE ===" -ForegroundColor Green
Write-Host "REBOOT REQUIRED. After reboot run:"
Write-Host "  wsl --status"
Write-Host "  docker info"
Write-Host "  docker run hello-world"
