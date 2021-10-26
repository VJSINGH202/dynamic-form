package com.adject.dynamicform;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EntityScan( basePackages = {"io.jetform.core.entity"})
@ComponentScan(basePackages = {"com.adject.dynamicform","io.jetform.core"})
public class DynamicFormApplication {

	public static void main(String[] args) {
		SpringApplication.run(DynamicFormApplication.class, args);
	}
}