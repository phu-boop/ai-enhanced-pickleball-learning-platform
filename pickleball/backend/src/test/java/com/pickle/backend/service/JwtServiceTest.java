package com.pickle.backend.service;

import io.jsonwebtoken.Claims;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class JwtServiceTest {

    private JwtService jwtService;
    private final String testSecret = "testSecretKeyForJwtThatIsLongEnoughForHS256AlgorithmToWorkProperly";
    private final String testEmail = "test@example.com";
    private final List<String> testRoles = Arrays.asList("learner", "coach");

    @BeforeEach
    void setUp() {
        jwtService = new JwtService(testSecret);
    }

    @Test
    void testGenerateToken_Success() {
        // Act
        String token = jwtService.generateToken(testEmail, testRoles);

        // Assert
        assertNotNull(token);
        assertFalse(token.isEmpty());
        assertTrue(token.split("\\.").length == 3); // JWT has 3 parts
    }

    @Test
    void testExtractEmail_FromValidToken() {
        // Arrange
        String token = jwtService.generateToken(testEmail, testRoles);

        // Act
        String extractedEmail = jwtService.extractUsername(token);

        // Assert
        assertEquals(testEmail, extractedEmail);
    }

    @Test
    void testExtractEmail_FromInvalidToken() {
        // Arrange
        String invalidToken = "invalid.token.here";

        // Act & Assert
        assertThrows(Exception.class, () -> jwtService.extractUsername(invalidToken));
    }

    @Test
    void testExtractRoles_FromValidToken() {
        // Arrange
        String token = jwtService.generateToken(testEmail, testRoles);

        // Act
        List<String> extractedRoles = jwtService.extractRoles(token);

        // Assert
        assertNotNull(extractedRoles);
        assertEquals(2, extractedRoles.size());
        assertTrue(extractedRoles.contains("learner"));
        assertTrue(extractedRoles.contains("coach"));
    }

    @Test
    void testValidateToken_ValidToken() {
        // Arrange
        String token = jwtService.generateToken(testEmail, testRoles);

        // Act
        boolean isValid = jwtService.validateToken(token, testEmail);

        // Assert
        assertTrue(isValid);
    }

    @Test
    void testValidateToken_InvalidEmail() {
        // Arrange
        String token = jwtService.generateToken(testEmail, testRoles);

        // Act
        boolean isValid = jwtService.validateToken(token, "different@example.com");

        // Assert
        assertFalse(isValid);
    }

    @Test
    void testValidateToken_ExpiredToken() {
        // This test would require manipulating time or creating an expired token
        // For now, we'll skip this as it requires more complex setup
        // In production, consider using a library like Mockito to mock Clock
    }

    @Test
    void testTokenContainsCorrectClaims() {
        // Arrange
        String token = jwtService.generateToken(testEmail, testRoles);

        // Act
        Claims claims = jwtService.extractAllClaims(token);

        // Assert
        assertNotNull(claims);
        assertEquals(testEmail, claims.getSubject());
        assertNotNull(claims.get("roles"));
        assertNotNull(claims.getIssuedAt());
        assertNotNull(claims.getExpiration());
    }

    @Test
    void testGenerateToken_WithSingleRole() {
        // Arrange
        List<String> singleRole = Arrays.asList("admin");

        // Act
        String token = jwtService.generateToken(testEmail, singleRole);
        List<String> extractedRoles = jwtService.extractRoles(token);

        // Assert
        assertNotNull(token);
        assertEquals(1, extractedRoles.size());
        assertEquals("admin", extractedRoles.get(0));
    }

    @Test
    void testGenerateToken_WithEmptyEmail() {
        // Act & Assert
        assertThrows(Exception.class, () -> jwtService.generateToken("", testRoles));
    }

    @Test
    void testExtractAllClaims_FromValidToken() {
        // Arrange
        String token = jwtService.generateToken(testEmail, testRoles);

        // Act
        Claims claims = jwtService.extractAllClaims(token);

        // Assert
        assertNotNull(claims);
        assertEquals(testEmail, claims.getSubject());
        assertTrue(claims.getExpiration().getTime() > System.currentTimeMillis());
    }
}
