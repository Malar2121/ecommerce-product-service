package com.swst41062.ecommerce.product.dto.response;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductResponse {

    private Long id;
    private String name;
    private String description;
    private String category;
    private BigDecimal unitPrice;
    private Integer stock;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
