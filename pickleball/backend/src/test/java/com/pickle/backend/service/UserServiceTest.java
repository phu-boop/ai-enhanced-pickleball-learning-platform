package com.pickle.backend.service;

import com.pickle.backend.entity.User;
import com.pickle.backend.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private UserService userService;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setUserId("test-user-id");
        testUser.setName("Test User");
        testUser.setEmail("test@example.com");
        testUser.setPassword("encodedPassword");
        testUser.setRole("learner");
    }

    @Test
    void testRegisterUser_Success() {
        // Arrange
        when(userRepository.findByEmail(anyString())).thenReturn(Optional.empty());
        when(passwordEncoder.encode(anyString())).thenReturn("encodedPassword");
        when(userRepository.save(any(User.class))).thenReturn(testUser);

        // Act
        User result = userService.registerUser("Test User", "test@example.com", "password123");

        // Assert
        assertNotNull(result);
        assertEquals("test@example.com", result.getEmail());
        verify(userRepository, times(1)).save(any(User.class));
        verify(passwordEncoder, times(1)).encode("password123");
    }

    @Test
    void testRegisterUser_EmailAlreadyExists() {
        // Arrange
        when(userRepository.findByEmail("test@example.com")).thenReturn(Optional.of(testUser));

        // Act & Assert
        RuntimeException exception = assertThrows(RuntimeException.class,
                () -> userService.registerUser("Test User", "test@example.com", "password123"));
        assertTrue(exception.getMessage().contains("Email already registered"));
        verify(userRepository, never()).save(any(User.class));
    }

    @Test
    void testCheckAccount_ValidCredentials() {
        // Arrange
        when(userRepository.findByEmail("test@example.com")).thenReturn(Optional.of(testUser));
        when(passwordEncoder.matches("password123", "encodedPassword")).thenReturn(true);

        // Act
        boolean result = userService.checkAccount("test@example.com", "password123");

        // Assert
        assertTrue(result);
        verify(userRepository, times(1)).findByEmail("test@example.com");
        verify(passwordEncoder, times(1)).matches("password123", "encodedPassword");
    }

    @Test
    void testCheckAccount_InvalidPassword() {
        // Arrange
        when(userRepository.findByEmail("test@example.com")).thenReturn(Optional.of(testUser));
        when(passwordEncoder.matches("wrongPassword", "encodedPassword")).thenReturn(false);

        // Act
        boolean result = userService.checkAccount("test@example.com", "wrongPassword");

        // Assert
        assertFalse(result);
    }

    @Test
    void testCheckAccount_UserNotFound() {
        // Arrange
        when(userRepository.findByEmail("nonexistent@example.com")).thenReturn(Optional.empty());

        // Act
        boolean result = userService.checkAccount("nonexistent@example.com", "password123");

        // Assert
        assertFalse(result);
        verify(passwordEncoder, never()).matches(anyString(), anyString());
    }

    @Test
    void testGetUserById_Success() {
        // Arrange
        when(userRepository.findById("test-user-id")).thenReturn(Optional.of(testUser));

        // Act
        Optional<User> result = userService.getUserById("test-user-id");

        // Assert
        assertTrue(result.isPresent());
        assertEquals("test@example.com", result.get().getEmail());
    }

    @Test
    void testGetUserById_NotFound() {
        // Arrange
        when(userRepository.findById("nonexistent-id")).thenReturn(Optional.empty());

        // Act
        Optional<User> result = userService.getUserById("nonexistent-id");

        // Assert
        assertFalse(result.isPresent());
    }

    @Test
    void testFindByEmail_Success() {
        // Arrange
        when(userRepository.findByEmail("test@example.com")).thenReturn(Optional.of(testUser));

        // Act
        Optional<User> result = userService.findByEmail("test@example.com");

        // Assert
        assertTrue(result.isPresent());
        assertEquals("Test User", result.get().getName());
    }

    @Test
    void testGetRoleByEmail_Success() {
        // Arrange
        when(userRepository.findByEmail("test@example.com")).thenReturn(Optional.of(testUser));

        // Act
        String role = userService.getRolebyEmail("test@example.com");

        // Assert
        assertEquals("learner", role);
    }

    @Test
    void testGetRoleByEmail_UserNotFound() {
        // Arrange
        when(userRepository.findByEmail("nonexistent@example.com")).thenReturn(Optional.empty());

        // Act
        String role = userService.getRolebyEmail("nonexistent@example.com");

        // Assert
        assertNull(role);
    }
}
