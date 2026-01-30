package com.pickle.backend.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class OpenAPIConfig {

    @Value("${BACKEND_URL_PUBLIC:http://localhost:8081}")
    private String backendUrl;

    @Bean
    public OpenAPI pickleballOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("PickleCoach AI API")
                        .description(
                                "REST API documentation for PickleCoach AI - A comprehensive pickleball coaching platform with AI-powered video analysis")
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("PickleCoach AI Team")
                                .email("support@picklecoach.ai"))
                        .license(new License()
                                .name("MIT License")
                                .url("https://opensource.org/licenses/MIT")))
                .servers(List.of(
                        new Server()
                                .url(backendUrl)
                                .description("Backend API Server")))
                .components(new Components()
                        .addSecuritySchemes("bearer-jwt", new SecurityScheme()
                                .type(SecurityScheme.Type.HTTP)
                                .scheme("bearer")
                                .bearerFormat("JWT")
                                .description("JWT token for authentication")))
                .addSecurityItem(new SecurityRequirement().addList("bearer-jwt"));
    }
}
