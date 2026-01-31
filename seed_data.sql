-- SQL Seed Data for PickleCoach-AI
-- Note: User IDs are UUIDs (36 chars)
-- Passwords are hashed using BCrypt (password: password123)

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM users;

DELETE FROM coaches;

DELETE FROM learners;

DELETE FROM courses;

DELETE FROM modules;

DELETE FROM lessons;

DELETE FROM question;

DELETE FROM question_options;

DELETE FROM sessions;

DELETE FROM debts;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. Users (Roles: ADMIN, COACH, USER)
INSERT INTO
    users (
        user_id,
        name,
        email,
        password,
        role,
        skill_level,
        login_type
    )
VALUES (
        'u1-admin-uuid-0000-000000000001',
        'System Admin',
        'admin@picklecoach.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'ADMIN',
        'ADVANCED',
        'LOCAL'
    ),
    (
        'u2-coach-uuid-0000-000000000002',
        'Coach Minh',
        'minh.coach@gmail.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'COACH',
        'ADVANCED',
        'LOCAL'
    ),
    (
        'u3-coach-uuid-0000-000000000003',
        'Coach Sarah',
        'sarah.p@gmail.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'COACH',
        'ADVANCED',
        'LOCAL'
    ),
    (
        'u4-learner-uuid-0000-000000000004',
        'Duy Phu',
        'devphu.learner@gmail.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'BEGINNER',
        'LOCAL'
    ),
    (
        'u5-learner-uuid-0000-000000000005',
        'John Wick',
        'john.wick@gmail.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'INTERMEDIATE',
        'LOCAL'
    );

-- 2. Coaches
INSERT INTO
    coaches (user_id, level)
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
        user_id,
        goals,
        progress,
        skill_level
    )
VALUES (
        'u4-learner-uuid-0000-000000000004',
        'Làm chủ cú đánh Dinking cơ bản',
        '10%',
        'BEGINNER'
    ),
    (
        'u5-learner-uuid-0000-000000000005',
        'Nâng cao kỹ thuật Smash và Serve',
        '45%',
        'INTERMEDIATE'
    );

-- 4. Courses
INSERT INTO
    courses (
        id,
        title,
        description,
        level_required,
        created_at
    )
VALUES (
        1,
        'Pickleball Basics for Beginners',
        'Learn the fundamental rules, strokes, and positioning.',
        'BEGINNER',
        NOW()
    ),
    (
        2,
        'Intermediate Strategy & Dinking',
        'Master the soft game and advanced court movement.',
        'INTERMEDIATE',
        NOW()
    ),
    (
        3,
        'Advanced Competition Techniques',
        'High-level serve variations and mental strategy.',
        'ADVANCED',
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
        'Basic Strokes',
        'Forehand and Backhand fundamentals.',
        2,
        1
    ),
    (
        3,
        'The Kitchen & Dinking',
        'Rule of the Non-Volley Zone.',
        1,
        2
    ),
    (
        4,
        'Serve & Return',
        'Consistency and placement.',
        2,
        2
    );

-- 6. Lessons (Lessons table uses BINARY(16) for ID, but can be hex strings)
-- Note: id is UUID. random hex for id.
INSERT INTO
    lessons (
        id,
        title,
        description,
        video_url,
        duration_seconds,
        skill_type,
        level,
        order_in_course,
        course_id,
        module_id,
        created_at
    )
VALUES (
        UNHEX (REPLACE(UUID(), '-', '')),
        'Choosing Your First Paddle',
        'What to look for in a paddle.',
        'https://example.com/video1',
        300,
        'GRIP',
        'BEGINNER',
        1,
        1,
        1,
        NOW()
    ),
    (
        UNHEX (REPLACE(UUID(), '-', '')),
        'The Eastern Grip',
        'How to hold the paddle for flexibility.',
        'https://example.com/video2',
        200,
        'GRIP',
        'BEGINNER',
        2,
        1,
        1,
        NOW()
    ),
    (
        UNHEX (REPLACE(UUID(), '-', '')),
        'Mastering the Dinks',
        'Keep it low and cross-court.',
        'https://example.com/video3',
        450,
        'DINK',
        'INTERMEDIATE',
        1,
        2,
        3,
        NOW()
    );

-- 7. Questions
INSERT INTO
    question (id, content, level, topic)
VALUES (
        1,
        'Vùng "The Kitchen" trong Pickleball là gì?',
        'BEGINNER',
        'RULES'
    ),
    (
        2,
        'Bạn được phép Volley bên trong Kitchen không?',
        'BEGINNER',
        'RULES'
    ),
    (
        3,
        'Cú đánh "Third Shot Drop" dùng để làm gì?',
        'INTERMEDIATE',
        'STRATEGY'
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
    ),
    (3, 'Vùng an toàn', 0, 1),
    (4, 'Có, bất cứ khi nào', 0, 2),
    (
        5,
        'Không, trừ khi bóng nẩy',
        1,
        2
    ),
    (
        6,
        'Để lên lưới an toàn',
        1,
        3
    ),
    (
        7,
        'Để kết thúc điểm số ngay',
        0,
        3
    );

-- 9. Sessions
INSERT INTO
    sessions (
        session_id,
        learner_id,
        coach_id,
        datetime,
        status,
        pakage,
        created_at
    )
VALUES (
        'sess-001',
        'u4-learner-uuid-0000-000000000004',
        'u2-coach-uuid-0000-000000000002',
        '2026-02-10 09:00',
        'SCHEDULED',
        'PAKAGE_5SESION',
        NOW()
    ),
    (
        'sess-002',
        'u5-learner-uuid-0000-000000000005',
        'u3-coach-uuid-0000-000000000003',
        '2026-02-11 15:00',
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
        'PENDING',
        'BANK_TRANSFER'
    );