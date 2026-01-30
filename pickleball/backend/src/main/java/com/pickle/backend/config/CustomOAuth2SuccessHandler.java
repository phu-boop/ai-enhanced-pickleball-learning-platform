package com.pickle.backend.config;

import com.pickle.backend.entity.User;
import com.pickle.backend.repository.UserRepository;
import com.pickle.backend.service.JwtService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Component
@Slf4j
public class CustomOAuth2SuccessHandler implements AuthenticationSuccessHandler {

    private final JwtService jwtService;
    private final UserRepository userRepository;

    public CustomOAuth2SuccessHandler(JwtService jwtService, UserRepository userRepository) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {
        try {
            OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
            String email = oAuth2User.getAttribute("email");
            String name = oAuth2User.getAttribute("name");

            log.info("OAuth2 Success - Received email: {}, name: {}", email, name);

            if (email == null || name == null) {
                throw new IllegalArgumentException("Email or name not found in OAuth2 response");
            }

            Optional<User> optionalUser = userRepository.findByEmail(email);
            User user = optionalUser.orElseGet(() -> {
                User newUser = new User();
                newUser.setUserId(UUID.randomUUID().toString());
                newUser.setEmail(email);
                newUser.setName(name);
                newUser.setPassword(null);
                newUser.setRole("USER");
                newUser.setPreferences("");
                newUser.setSkillLevel("");
                log.info("Saving new user: {}", newUser);
                return userRepository.save(newUser);
            });

            String token = jwtService.generateToken(user.getEmail(), List.of(user.getRole()));
            if (token == null || token.isEmpty()) {
                throw new IllegalStateException("Failed to generate JWT token");
            }
            log.debug("Generated token for user: {}", user.getEmail());
            String successMessage = optionalUser.isPresent() ? "Login successful"
                    : "User registered successfully with ID: " + user.getUserId();

            // Redirect to /oauth2/redirect instead of /home
            String redirectUrl = "http://localhost:5173/oauth2/redirect" +
                    "?token=" + URLEncoder.encode(token, StandardCharsets.UTF_8) +
                    "&role=" + URLEncoder.encode(user.getRole(), StandardCharsets.UTF_8) +
                    "&message=" + URLEncoder.encode(successMessage, StandardCharsets.UTF_8);
            log.debug("Redirecting to: {}", redirectUrl);
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            log.error("Error in OAuth2 handler: ", e);
            String errorMessage = "Internal server error: " + e.getMessage();
            response.sendRedirect(
                    "http://localhost:5173/login?error=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
        }
    }
}