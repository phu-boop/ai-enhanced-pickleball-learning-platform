package com.pickle.backend.controller;

import com.pickle.backend.dto.UserRegistrationRequest;
import com.pickle.backend.entity.User;
import com.pickle.backend.service.UserService;
import com.pickle.backend.service.JwtService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserController.class)
class UserControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private UserService userService;

    @MockBean
    private JwtService jwtService;

    @Test
    void testRegisterUser_Success() throws Exception {
        // Arrange
        UserRegistrationRequest request = new UserRegistrationRequest();
        request.setName("Test User");
        request.setEmail("test@example.com");
        request.setPassword("password123");

        User savedUser = new User();
        savedUser.setUserId("test-id");
        savedUser.setEmail("test@example.com");

        when(userService.registerUser(anyString(), anyString(), anyString())).thenReturn(savedUser);

        // Act & Assert
        mockMvc.perform(post("/api/users/register")
                .with(csrf())
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(content().string(org.hamcrest.Matchers.containsString("test-id")));
    }

    @Test
    void testRegisterUser_EmailAlreadyExists() throws Exception {
        // Arrange
        UserRegistrationRequest request = new UserRegistrationRequest();
        request.setName("Test User");
        request.setEmail("existing@example.com");
        request.setPassword("password123");

        when(userService.registerUser(anyString(), anyString(), anyString()))
                .thenThrow(new RuntimeException("Email already registered"));

        // Act & Assert
        mockMvc.perform(post("/api/users/register")
                .with(csrf())
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest())
                .andExpect(content().string("Email already registered"));
    }

    @Test
    void testLogin_Success() throws Exception {
        // Arrange
        UserRegistrationRequest loginRequest = new UserRegistrationRequest();
        loginRequest.setEmail("test@example.com");
        loginRequest.setPassword("password123");

        when(userService.checkAccount("test@example.com", "password123")).thenReturn(true);
        when(userService.getRolebyEmail("test@example.com")).thenReturn("learner");
        when(userService.getIdbyEmail("test@example.com")).thenReturn("user-id-123");
        when(jwtService.generateToken(anyString(), any())).thenReturn("mock-jwt-token");

        // Act & Assert
        mockMvc.perform(post("/api/users/login")
                .with(csrf())
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.token").value("mock-jwt-token"))
                .andExpect(jsonPath("$.message").value("login successful"))
                .andExpect(jsonPath("$.role").value("learner"))
                .andExpect(jsonPath("$.id_user").value("user-id-123"));
    }

    @Test
    void testLogin_InvalidCredentials() throws Exception {
        // Arrange
        UserRegistrationRequest loginRequest = new UserRegistrationRequest();
        loginRequest.setEmail("test@example.com");
        loginRequest.setPassword("wrongpassword");

        when(userService.checkAccount("test@example.com", "wrongpassword")).thenReturn(false);

        // Act & Assert
        mockMvc.perform(post("/api/users/login")
                .with(csrf())
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.message").value("Invalid email or password"));
    }

    @Test
    @WithMockUser(roles = "ADMIN")
    void testGetAllUsers_AsAdmin() throws Exception {
        // Arrange
        User user1 = new User();
        user1.setUserId("1");
        user1.setEmail("user1@example.com");

        User user2 = new User();
        user2.setUserId("2");
        user2.setEmail("user2@example.com");

        when(userService.getAllUsers()).thenReturn(Arrays.asList(user1, user2));

        // Act & Assert
        mockMvc.perform(get("/api/users")
                .with(csrf()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$.length()").value(2));
    }

    @Test
    void testGetUserById_Success() throws Exception {
        // Arrange
        User user = new User();
        user.setUserId("test-id");
        user.setEmail("test@example.com");

        when(userService.getUserById("test-id")).thenReturn(Optional.of(user));

        // Act & Assert
        mockMvc.perform(get("/api/users/test-id")
                .with(csrf()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.userId").value("test-id"))
                .andExpect(jsonPath("$.email").value("test@example.com"));
    }

    @Test
    void testGetUserById_NotFound() throws Exception {
        // Arrange
        when(userService.getUserById("nonexistent-id")).thenReturn(Optional.empty());

        // Act & Assert
        mockMvc.perform(get("/api/users/nonexistent-id")
                .with(csrf()))
                .andExpect(status().isNotFound());
    }
}
