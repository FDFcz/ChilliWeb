package com.example.chilliweb;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class Coniguration implements WebMvcConfigurer
{
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Mapa URL /gallery/** na externí složku na disku
        registry.addResourceHandler("/gallery/**")
                .addResourceLocations("file:/home/Chilli/ChilliWeb/gallery/");
        System.out.println(registry.hasMappingForPattern("/gallery/**"));
    }
}
