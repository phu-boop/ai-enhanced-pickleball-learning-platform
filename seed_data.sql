-- SQL Seed Data for PickleCoach-AI
-- Strictly matched to Backend Entity Schema
-- Passwords are hashed using BCrypt (password: password123)

SET FOREIGN_KEY_CHECKS = 0;

-- Delete in reverse dependency order (Children first)
DELETE FROM debts;

DELETE FROM sessions;

DELETE FROM learners;

DELETE FROM coaches;

DELETE FROM users;

DELETE FROM question_options;

DELETE FROM question;

DELETE FROM lessons;

DELETE FROM modules;

DELETE FROM courses;

-- 1. Users (Roles: ADMIN, COACH, USER)
INSERT INTO
    users (
        userId,
        name,
        email,
        password,
        role,
        skill_level,
        login_type,
        url_avata,
        created_at
    )
VALUES
    -- Admins
    (
        'u1-admin-uuid-0000-000000000001',
        'System Admin',
        'admin@picklecoach.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'ADMIN',
        'ADVANCED',
        'LOCAL',
        'https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    -- Coaches
    (
        'u2-coach-uuid-0000-000000000002',
        'Coach Minh Nguyen',
        'minh.coach@gmail.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'COACH',
        'ADVANCED',
        'LOCAL',
        'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    (
        'u3-coach-uuid-0000-000000000003',
        'Coach Sarah Parker',
        'sarah.p@picklecoach.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'COACH',
        'ADVANCED',
        'LOCAL',
        'https://images.unsplash.com/photo-1569913486515-b74bf7751574?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    -- Learners
    (
        'u4-learner-uuid-0000-000000000004',
        'Duy Phu Nguyen',
        'devphu.learner@gmail.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'BEGINNER',
        'LOCAL',
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    (
        'u5-learner-uuid-0000-000000000005',
        'Tran Anh',
        'trananh@email.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'INTERMEDIATE',
        'LOCAL',
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    );

-- 2. Coaches
INSERT INTO
    coaches (userId, level)
VALUES (
        'u2-coach-uuid-0000-000000000002',
        'ADVANCED'
    ),
    (
        'u3-coach-uuid-0000-000000000003',
        'ADVANCED'
    );

-- 3. Learners
INSERT INTO
    learners (
        userId,
        goals,
        progress,
        skillLevel
    )
VALUES (
        'u4-learner-uuid-0000-000000000004',
        'Master dinking and basic serves.',
        '25%',
        'BEGINNER'
    ),
    (
        'u5-learner-uuid-0000-000000000005',
        'Improve third shot drop and court positioning.',
        '65%',
        'INTERMEDIATE'
    );

-- 4. Courses
INSERT INTO
    courses (
        id,
        title,
        description,
        level_required,
        thumbnail_url,
        created_at
    )
VALUES (
        1,
        'Pickleball Basics for Beginners',
        'Complete beginner course covering rules and basic strokes.',
        'BEGINNER',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        NOW()
    ),
    (
        2,
        'Intermediate Strategy & Dinking',
        'Master the soft game and advanced court movement.',
        'INTERMEDIATE',
        'https://images.unsplash.com/photo-1595435934247-5d33b7f92c60?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        NOW()
    );

-- 5. Modules
INSERT INTO
    modules (
        id,
        title,
        description,
        order_in_course,
        course_id
    )
VALUES (
        1,
        'Introduction to Equipment',
        'Choosing the right paddle and ball.',
        1,
        1
    ),
    (
        2,
        'The Kitchen & Dinking',
        'Rule of the Non-Volley Zone.',
        1,
        2
    );

-- 6. Lessons
INSERT INTO
    lessons (
        id,
        title,
        description,
        video_url,
        duration_seconds,
        level,
        skill_type,
        order_in_module,
        order_in_course,
        course_id,
        module_id,
        thumbnail_url,
        created_at
    )
VALUES (
        UNHEX (REPLACE(UUID(), '-', '')),
        'Choosing Your First Paddle',
        'What to look for in a paddle.',
        'https://www.youtube.com/watch?v=zL0HvG8Bjr8',
        420,
        'BEGINNER',
        'GRIP',
        1,
        1,
        1,
        1,
        'https://img.youtube.com/vi/zL0HvG8Bjr8/maxresdefault.jpg',
        NOW()
    ),
    (
        UNHEX (REPLACE(UUID(), '-', '')),
        'Mastering the Dinks',
        'Keep it low and cross-court.',
        'https://www.youtube.com/watch?v=uQvCPwL-khM',
        540,
        'INTERMEDIATE',
        'DINK',
        1,
        1,
        2,
        2,
        'https://img.youtube.com/vi/uQvCPwL-khM/maxresdefault.jpg',
        NOW()
    );

-- 7. Questions
INSERT INTO
    question (
        id,
        content,
        level,
        topic,
        explanation,
        image_url
    )
VALUES (
        1,
        'Vùng "The Kitchen" trong Pickleball là gì?',
        'BEGINNER',
        'RULES',
        'The Kitchen là vùng 7 feet từ lưới nơi không được volley.',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80'
    );

-- 8. Question Options
INSERT INTO
    question_options (
        id,
        content,
        is_correct,
        question_id
    )
VALUES (1, 'Vùng cấm giao bóng', 0, 1),
    (
        2,
        'Vùng Non-Volley Zone',
        1,
        1
    );

-- 9. Sessions
INSERT INTO
    sessions (
        sessionId,
        learnerId,
        coachId,
        datetime,
        status,
        pakage,
        created_at
    )
VALUES (
        'sess-001',
        'u4-learner-uuid-0000-000000000004',
        'u2-coach-uuid-0000-000000000002',
        '2024-02-10 09:00:00',
        'COMPLETED',
        'PAKAGE_5SESION',
        NOW()
    ),
    (
        'sess-002',
        'u5-learner-uuid-0000-000000000005',
        'u3-coach-uuid-0000-000000000003',
        '2024-02-11 15:00:00',
        'IN_PROGRESS',
        'PAKAGE_10SESION',
        NOW()
    );

-- 10. Debts
INSERT INTO
    debts (
        id,
        learner_id,
        coach_id,
        session_id,
        amount,
        status,
        method
    )
VALUES (
        1,
        'u4-learner-uuid-0000-000000000004',
        'u2-coach-uuid-0000-000000000002',
        'sess-001',
        50.00,
        'PAID',
        'CREDIT_CARD'
    );

SET FOREIGN_KEY_CHECKS = 1;

SELECT 'Seed data inserted successfully!' AS message;