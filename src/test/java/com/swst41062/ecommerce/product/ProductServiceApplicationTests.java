package com.swst41062.ecommerce.product;

import com.swst41062.ecommerce.product.repository.ProductRepository;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test")
class ProductServiceApplicationTests {

	@MockBean
	private ProductRepository productRepository;

	@Test
	void contextLoads() {
	}

}
