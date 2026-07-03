package com.swst41062.ecommerce.product.service;

import com.swst41062.ecommerce.product.dto.request.ProductRequest;
import com.swst41062.ecommerce.product.dto.response.ProductResponse;

public interface ProductService {

    ProductResponse createProduct(ProductRequest request);

    ProductResponse getProductById(Long id);

    void deleteProduct(Long id);
}
