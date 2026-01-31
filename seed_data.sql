-- SQL Seed Data for PickleCoach-AI
-- Extensive dataset with realistic URLs and multiple records
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
        user_id,
        name,
        email,
        password,
        role,
        skill_level,
        login_type,
        profile_image,
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
    (
        'u6-coach-uuid-0000-000000000006',
        'Coach David Chen',
        'david.chen@procoach.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'COACH',
        'ADVANCED',
        'LOCAL',
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    (
        'u7-coach-uuid-0000-000000000007',
        'Coach Maria Rodriguez',
        'maria.rodriguez@picklepro.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'COACH',
        'ADVANCED',
        'LOCAL',
        'https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
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
        'John Wick',
        'john.wick@gmail.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'INTERMEDIATE',
        'LOCAL',
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    (
        'u8-learner-uuid-0000-000000000008',
        'Emma Wilson',
        'emma.wilson@email.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'BEGINNER',
        'LOCAL',
        'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    (
        'u9-learner-uuid-0000-000000000009',
        'Michael Brown',
        'michael.brown@email.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'INTERMEDIATE',
        'LOCAL',
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    (
        'u10-learner-uuid-0000-0000000010',
        'Sophia Garcia',
        'sophia.garcia@email.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'ADVANCED',
        'LOCAL',
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    (
        'u11-learner-uuid-0000-0000000011',
        'James Miller',
        'james.miller@email.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'BEGINNER',
        'LOCAL',
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    ),
    (
        'u12-learner-uuid-0000-0000000012',
        'Olivia Taylor',
        'olivia.taylor@email.com',
        '$2a$10$vI8tmv9s4Oasq4L2p9p66u2O1.5sR.i8.H0p9tq.oY9p9s.z.A.O.',
        'USER',
        'INTERMEDIATE',
        'LOCAL',
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        NOW()
    );

-- 2. Coaches
INSERT INTO
    coaches (
        user_id,
        level,
        bio,
        hourly_rate,
        rating,
        total_students,
        years_experience,
        specialties
    )
VALUES (
        'u2-coach-uuid-0000-000000000002',
        'ADVANCED',
        'Professional pickleball coach with 10+ years experience. Former national champion specializing in beginner training and advanced strategy.',
        75.00,
        4.9,
        150,
        12,
        'BEGINNER_TRAINING,ADVANCED_STRATEGY,DRILLS'
    ),
    (
        'u3-coach-uuid-0000-000000000003',
        'ADVANCED',
        'Certified PPR coach focusing on technique improvement and mental game. Passionate about helping players reach their full potential.',
        65.00,
        4.8,
        120,
        8,
        'TECHNIQUE,MENTAL_GAME,SERVE_RETURN'
    ),
    (
        'u6-coach-uuid-0000-000000000006',
        'ADVANCED',
        'Competitive player turned coach. Specializes in doubles strategy and tournament preparation.',
        80.00,
        4.7,
        90,
        6,
        'DOUBLES_STRATEGY,TOURNAMENT_PREP,FOOTWORK'
    ),
    (
        'u7-coach-uuid-0000-000000000007',
        'ADVANCED',
        'Youth development specialist. Creating fun and engaging lessons for all ages and skill levels.',
        60.00,
        4.9,
        200,
        10,
        'YOUTH_DEVELOPMENT,FUN_DRILLS,FUNDAMENTALS'
    );

-- 3. Learners
INSERT INTO
    learners (
        user_id,
        goals,
        progress,
        skill_level,
        total_hours,
        favorite_coach_id,
        joined_date
    )
VALUES (
        'u4-learner-uuid-0000-000000000004',
        'Master basic dinking techniques, improve serve consistency, learn proper footwork',
        '25%',
        'BEGINNER',
        12.5,
        'u2-coach-uuid-0000-000000000002',
        '2024-01-15'
    ),
    (
        'u5-learner-uuid-0000-000000000005',
        'Improve third shot drop, master lob shots, enhance court positioning',
        '65%',
        'INTERMEDIATE',
        45.0,
        'u3-coach-uuid-0000-000000000003',
        '2023-11-10'
    ),
    (
        'u8-learner-uuid-0000-000000000008',
        'Learn basic rules, proper grip, understand scoring system',
        '15%',
        'BEGINNER',
        5.0,
        'u2-coach-uuid-0000-000000000002',
        '2024-02-01'
    ),
    (
        'u9-learner-uuid-0000-000000000009',
        'Improve backhand shots, learn spin techniques, better communication in doubles',
        '50%',
        'INTERMEDIATE',
        30.0,
        'u6-coach-uuid-0000-000000000006',
        '2023-12-20'
    ),
    (
        'u10-learner-uuid-0000-0000000010',
        'Tournament preparation, advanced strategy, mental toughness',
        '85%',
        'ADVANCED',
        100.0,
        'u7-coach-uuid-0000-000000000007',
        '2023-09-05'
    ),
    (
        'u11-learner-uuid-0000-0000000011',
        'Basic paddle control, understanding kitchen rules, simple serves',
        '10%',
        'BEGINNER',
        3.5,
        NULL,
        '2024-02-15'
    ),
    (
        'u12-learner-uuid-0000-0000000012',
        'Consistent dinking, better volleys, improved serve accuracy',
        '40%',
        'INTERMEDIATE',
        25.0,
        'u3-coach-uuid-0000-000000000003',
        '2024-01-10'
    );

-- 4. Courses
INSERT INTO
    courses (
        id,
        title,
        description,
        level_required,
        image_url,
        price,
        duration_hours,
        enrolled_students,
        rating,
        created_at
    )
VALUES (
        1,
        'Pickleball Basics for Beginners',
        'Complete beginner course covering rules, equipment, basic strokes, and court positioning. Perfect for those new to the sport.',
        'BEGINNER',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        99.99,
        8.0,
        245,
        4.8,
        NOW()
    ),
    (
        2,
        'Intermediate Strategy & Dinking',
        'Master the soft game, advanced court movement, and strategic play. Learn to control the kitchen line.',
        'INTERMEDIATE',
        'https://images.unsplash.com/photo-1595435934247-5d33b7f92c60?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        149.99,
        12.0,
        178,
        4.9,
        NOW()
    ),
    (
        3,
        'Advanced Competition Techniques',
        'High-level serve variations, mental strategy, and tournament preparation. For serious competitive players.',
        'ADVANCED',
        'https://images.unsplash.com/photo-1552674605-db6ffd8facb5?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        199.99,
        15.0,
        89,
        4.7,
        NOW()
    ),
    (
        4,
        'Doubles Strategy Mastery',
        'Learn advanced doubles positioning, communication, and team strategies to dominate the court.',
        'INTERMEDIATE',
        'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        129.99,
        10.0,
        156,
        4.6,
        NOW()
    ),
    (
        5,
        'Serve & Return Excellence',
        'Master every type of serve and return. Learn placement, spin, and power techniques.',
        'ALL_LEVELS',
        'https://images.unsplash.com/photo-1518611012118-696072aa579a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        89.99,
        6.0,
        312,
        4.9,
        NOW()
    ),
    (
        6,
        'Youth Development Program',
        'Fun and engaging pickleball lessons designed specifically for young players aged 8-16.',
        'BEGINNER',
        'https://images.unsplash.com/photo-1517649763962-0c623066013b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        79.99,
        5.0,
        134,
        4.8,
        NOW()
    );

-- 5. Modules
INSERT INTO
    modules (
        id,
        title,
        description,
        order_in_course,
        course_id,
        estimated_time_minutes
    )
VALUES
    -- Course 1 Modules
    (
        1,
        'Introduction to Equipment',
        'Choosing the right paddle, balls, and court shoes.',
        1,
        1,
        45
    ),
    (
        2,
        'Basic Rules & Scoring',
        'Understanding the rules, scoring system, and court layout.',
        2,
        1,
        60
    ),
    (
        3,
        'Fundamental Strokes',
        'Forehand, backhand, and volley basics.',
        3,
        1,
        90
    ),
    (
        4,
        'Serve Basics',
        'Learning proper serving technique and placement.',
        4,
        1,
        60
    ),
    (
        5,
        'Court Positioning',
        'Where to stand in singles and doubles play.',
        5,
        1,
        45
    ),

-- Course 2 Modules
(
    6,
    'The Kitchen & Dinking',
    'Mastering the non-volley zone and soft game.',
    1,
    2,
    120
),
(
    7,
    'Third Shot Strategies',
    'Drop shots, drives, and when to use them.',
    2,
    2,
    90
),
(
    8,
    'Advanced Footwork',
    'Efficient court movement and recovery.',
    3,
    2,
    75
),
(
    9,
    'Spin Techniques',
    'Adding topspin and slice to your shots.',
    4,
    2,
    90
),

-- Course 3 Modules
(
    10,
    'Competition Mindset',
    'Mental preparation and strategy for tournaments.',
    1,
    3,
    60
),
(
    11,
    'Advanced Serve Variations',
    'Power serves, spin serves, and placement.',
    2,
    3,
    120
),
(
    12,
    'Defensive Strategies',
    'Handling hard shots and recovering from defense.',
    3,
    3,
    90
),
(
    13,
    'Game Analysis',
    'Analyzing opponents and adjusting strategy.',
    4,
    3,
    75
),

-- Course 4 Modules
(14, 'Doubles Communication', 'Effective communication and signals.', 1, 4, 60),
(15, 'Stacking & Switching', 'Advanced positioning techniques.', 2, 4, 90),
(16, 'Team Strategy', 'Playing to your partner\'s strengths.', 3, 4, 75),

-- Course 5 Modules
(
    17,
    'Serve Fundamentals',
    'Perfecting your basic serve.',
    1,
    5,
    45
),
(
    18,
    'Return of Serve',
    'Positioning and shot selection.',
    2,
    5,
    60
),
(
    19,
    'Advanced Serves',
    'Adding power, spin, and deception.',
    3,
    5,
    90
),

-- Course 6 Modules
(
    20,
    'Fun Drills for Kids',
    'Engaging activities to teach basics.',
    1,
    6,
    45
),
(
    21,
    'Youth Rules Simplified',
    'Making rules easy for young players.',
    2,
    6,
    30
),
(
    22,
    'Progressive Skill Building',
    'Gradually increasing difficulty.',
    3,
    6,
    60
);

-- 6. Lessons
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
        thumbnail_url,
        created_at
    )
VALUES
    -- Course 1 Lessons
    (
        UNHEX (REPLACE(UUID(), '-', '')),
        'Choosing Your First Paddle',
        'Learn what to look for in your first pickleball paddle including weight, grip size, and material.',
        'https://www.youtube.com/watch?v=zL0HvG8Bjr8',
        420,
        'EQUIPMENT',
        'BEGINNER',
        1,
        1,
        1,
        'https://img.youtube.com/vi/zL0HvG8Bjr8/maxresdefault.jpg',
        NOW()
    ),
    (
        UNHEX (REPLACE(UUID(), '-', '')),
        'The Eastern Grip',
        'Master the most common grip used in pickleball for maximum control and flexibility.',
        'https://www.youtube.com/watch?v=6WZ8F2h5_eg',
        300,
        'GRIP',
        'BEGINNER',
        2,
        1,
        1,
        'https://img.youtube.com/vi/6WZ8F2h5_eg/maxresdefault.jpg',
        NOW()
    ),
    (
        UNHEX (REPLACE(UUID(), '-', '')),
        'Basic Rules Overview',
        'Understand the fundamental rules of pickleball including scoring, serving, and kitchen rules.',
        'https://www.youtube.com/watch?v=wZbYhrZqZ_c',
        600,
        'RULES',
        'BEGINNER',
        1,
        1,
        2,
        'https://img.youtube.com/vi/wZbYhrZqZ_c/maxresdefault.jpg',
        NOW()
    ),
    (
        UNHEX (REPLACE(UUID(), '-', '')),
        'Forehand Fundamentals',
        'Learn proper forehand technique including stance, swing, and follow-through.',
        'https://www.youtube.com/watch?v=2kL_jjB6s3k',
        480,
        'FOREHAND',
        'BEGINNER',
        1,
        1,
        3,
        'https://img.youtube.com/vi/2kL_jjB6s3k/maxresdefault.jpg',
        NOW()
    ),
    (
        UNHEX (REPLACE(UUID(), '-', '')),
        'Backhand Basics',
        'Master the backhand stroke with proper form and positioning.',
        'https://www.youtube.com/watch?v=5M2R-Y-hj5c',
        450,
        'BACKHAND',
        'BEGINNER',
        2,
        1,
        3,
        'https://img.youtube.com/vi/5M2R-Y-hj5c/maxresdefault.jpg',
        NOW()
    ),

-- Course 2 Lessons
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Mastering the Dinks',
    'Learn how to execute perfect dinks to control the kitchen line.',
    'https://www.youtube.com/watch?v=uQvCPwL-khM',
    540,
    'DINK',
    'INTERMEDIATE',
    1,
    2,
    6,
    'https://img.youtube.com/vi/uQvCPwL-khM/maxresdefault.jpg',
    NOW()
),
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Cross-Court Dinking',
    'Practice cross-court dinking patterns to control the point.',
    'https://www.youtube.com/watch?v=TMTN5B9lBAA',
    480,
    'DINK',
    'INTERMEDIATE',
    2,
    2,
    6,
    'https://img.youtube.com/vi/TMTN5B9lBAA/maxresdefault.jpg',
    NOW()
),
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Third Shot Drop Technique',
    'Learn the crucial third shot drop to safely approach the net.',
    'https://www.youtube.com/watch?v=K_0vKSk-3wI',
    600,
    'DROP_SHOT',
    'INTERMEDIATE',
    1,
    2,
    7,
    'https://img.youtube.com/vi/K_0vKSk-3wI/maxresdefault.jpg',
    NOW()
),
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Lateral Movement Drills',
    'Improve side-to-side court coverage with specific footwork drills.',
    'https://www.youtube.com/watch?v=YGZW0h8II-o',
    420,
    'FOOTWORK',
    'INTERMEDIATE',
    1,
    2,
    8,
    'https://img.youtube.com/vi/YGZW0h8II-o/maxresdefault.jpg',
    NOW()
),

-- Course 3 Lessons
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Tournament Preparation',
    'Mental and physical preparation for competitive play.',
    'https://www.youtube.com/watch?v=ZzX7vjCkQqA',
    660,
    'STRATEGY',
    'ADVANCED',
    1,
    3,
    10,
    'https://img.youtube.com/vi/ZzX7vjCkQqA/maxresdefault.jpg',
    NOW()
),
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Power Serve Development',
    'Learn how to add power to your serve while maintaining accuracy.',
    'https://www.youtube.com/watch?v=7mCQw4B2cCY',
    480,
    'SERVE',
    'ADVANCED',
    1,
    3,
    11,
    'https://img.youtube.com/vi/7mCQw4B2cCY/maxresdefault.jpg',
    NOW()
),
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Spin Serve Mastery',
    'Add topspin and slice to your serves to create difficulty for opponents.',
    'https://www.youtube.com/watch?v=4pX6Q3yB_3s',
    540,
    'SERVE',
    'ADVANCED',
    2,
    3,
    11,
    'https://img.youtube.com/vi/4pX6Q3yB_3s/maxresdefault.jpg',
    NOW()
),

-- Course 4 Lessons
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Doubles Communication Signals',
    'Learn hand signals and verbal cues for effective doubles communication.',
    'https://www.youtube.com/watch?v=XZ5TwjJt6h0',
    360,
    'COMMUNICATION',
    'INTERMEDIATE',
    1,
    4,
    14,
    'https://img.youtube.com/vi/XZ5TwjJt6h0/maxresdefault.jpg',
    NOW()
),
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Stacking Strategy',
    'Advanced positioning technique to maximize strengths in doubles.',
    'https://www.youtube.com/watch?v=Wj7pK6O-dbE',
    480,
    'POSITIONING',
    'ADVANCED',
    1,
    4,
    15,
    'https://img.youtube.com/vi/Wj7pK6O-dbE/maxresdefault.jpg',
    NOW()
),

-- Course 5 Lessons
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Serve Placement Targets',
    'Learn where to place serves against different opponents.',
    'https://www.youtube.com/watch?v=9cBxMq11aOo',
    420,
    'SERVE',
    'INTERMEDIATE',
    1,
    5,
    17,
    'https://img.youtube.com/vi/9cBxMq11aOo/maxresdefault.jpg',
    NOW()
),
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Return of Serve Positioning',
    'Optimal positioning for returning different types of serves.',
    'https://www.youtube.com/watch?v=Rhk8Nw4qH_w',
    450,
    'RETURN',
    'INTERMEDIATE',
    1,
    5,
    18,
    'https://img.youtube.com/vi/Rhk8Nw4qH_w/maxresdefault.jpg',
    NOW()
),

-- Course 6 Lessons
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Fun Relay Races',
    'Engaging relay races to teach movement and paddle control.',
    'https://www.youtube.com/watch?v=yP5XjfWZ6uE',
    300,
    'DRILLS',
    'BEGINNER',
    1,
    6,
    20,
    'https://img.youtube.com/vi/yP5XjfWZ6uE/maxresdefault.jpg',
    NOW()
),
(
    UNHEX (REPLACE(UUID(), '-', '')),
    'Target Practice Games',
    'Fun games to improve accuracy and control.',
    'https://www.youtube.com/watch?v=3fV3XrW1Gc4',
    360,
    'ACCURACY',
    'BEGINNER',
    2,
    6,
    20,
    'https://img.youtube.com/vi/3fV3XrW1Gc4/maxresdefault.jpg',
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
VALUES
    -- Rules Questions
    (
        1,
        'Vùng "The Kitchen" trong Pickleball là gì?',
        'BEGINNER',
        'RULES',
        'The Kitchen (Non-Volley Zone) là vùng 7 feet từ lưới nơi người chơi không được volley bóng (đánh bóng trên không trước khi bóng nảy).',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80'
    ),
    (
        2,
        'Bạn được phép Volley bên trong Kitchen không?',
        'BEGINNER',
        'RULES',
        'Không, bạn không được volley bóng khi bất kỳ phần nào của cơ thể chạm vào Kitchen hoặc đường Kitchen. Bạn chỉ được đánh bóng trong Kitchen nếu bóng đã nảy trước.',
        NULL
    ),
    (
        3,
        'Điểm số bắt đầu từ bao nhiêu trong Pickleball?',
        'BEGINNER',
        'RULES',
        'Tất cả các game pickleball bắt đầu với điểm số 0-0. Người giao bóng luôn gọi điểm của mình trước, sau đó điểm của đối thủ.',
        NULL
    ),
    (
        4,
        'Cú đánh "Third Shot Drop" dùng để làm gì?',
        'INTERMEDIATE',
        'STRATEGY',
        'Third Shot Drop được sử dụng để đưa bóng nhẹ nhàng vào Kitchen, cho phép đội tấn công tiến lên lưới một cách an toàn sau khi giao bóng và trả giao bóng.',
        'https://images.unsplash.com/photo-1595435934247-5d33b7f92c60?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80'
    ),

-- Strategy Questions
(
    5,
    'Khi nào nên sử dụng "Lob Shot"?',
    'INTERMEDIATE',
    'STRATEGY',
    'Lob nên được sử dụng khi đối thủ đứng quá gần lưới, để buộc họ lùi lại và tạo khoảng trống trên sân. Cũng hiệu quả khi đối mặt với đội chơi lưới mạnh.',
    NULL
),
(
    6,
    'Chiến lược tốt nhất để chống lại đội có cú "Smash" mạnh?',
    'ADVANCED',
    'STRATEGY',
    'Giữ bóng thấp và vào Kitchen để hạn chế cơ hội smash của đối thủ. Sử dụng nhiều dink và drop shots thay vì đưa bóng cao.',
    NULL
),
(
    7,
    'Vị trí tối ưu trong đánh đôi là gì?',
    'INTERMEDIATE',
    'POSITIONING',
    'Trong đánh đôi, cả hai người nên đứng gần Kitchen line, song song với nhau, và di chuyển cùng nhau như một đơn vị.',
    'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80'
),

-- Technique Questions
(
    8,
    'Cách cầm vợt nào phổ biến nhất trong Pickleball?',
    'BEGINNER',
    'TECHNIQUE',
    'Eastern grip là cách cầm phổ biến nhất, cho phép linh hoạt giữa forehand và backhand mà không cần thay đổi tay cầm.',
    NULL
),
(
    9,
    'Cách hiệu quả nhất để cải thiện độ chính xác của cú "Dink"?',
    'INTERMEDIATE',
    'TECHNIQUE',
    'Tập trung vào việc sử dụng chân và hông để tạo lực, thay vì chỉ dùng tay. Giữ cổ tay chắc và follow-through ngắn.',
    NULL
),
(
    10,
    'Kỹ thuật "Topspin" giúp ích gì cho cú đánh?',
    'ADVANCED',
    'TECHNIQUE',
    'Topspin làm bóng nảy cao hơn và di chuyển nhanh hơn sau khi chạm đất, đồng thời giúp bóng rơi nhanh hơn trong sân.',
    NULL
),

-- Equipment Questions
(
    11,
    'Paddle nặng hay nhẹ tốt hơn cho người mới bắt đầu?',
    'BEGINNER',
    'EQUIPMENT',
    'Paddle trung bình (7.8-8.2 oz) thường tốt nhất cho người mới bắt đầu vì cân bằng giữa kiểm soát và sức mạnh.',
    'https://images.unsplash.com/photo-1575361204480-aadea25e6e68?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80'
),
(
    12,
    'Bóng trong nhà và ngoài trời khác nhau như thế nào?',
    'BEGINNER',
    'EQUIPMENT',
    'Bóng ngoài trời nhỏ hơn, nặng hơn, và có nhiều lỗ nhỏ hơn để chống gió. Bóng trong nhà lớn hơn, nhẹ hơn, và có lỗ lớn hơn.',
    NULL
);

-- 8. Question Options
INSERT INTO
    question_options (
        id,
        content,
        is_correct,
        question_id
    )
VALUES
    -- Question 1 options
    (1, 'Vùng cấm giao bóng', 0, 1),
    (
        2,
        'Vùng Non-Volley Zone',
        1,
        1
    ),
    (3, 'Vùng an toàn', 0, 1),
    (
        4,
        'Vùng tính điểm đặc biệt',
        0,
        1
    ),

-- Question 2 options
(5, 'Có, bất cứ khi nào', 0, 2),
(
    6,
    'Không, trừ khi bóng nẩy',
    1,
    2
),
(7, 'Chỉ khi giao bóng', 0, 2),
(8, 'Chỉ trong đánh đôi', 0, 2),

-- Question 3 options
(9, '0-0', 1, 3),
(10, '1-0', 0, 3),
(11, '2-2', 0, 3),
(12, '5-5', 0, 3),

-- Question 4 options
(
    13,
    'Để lên lưới an toàn',
    1,
    4
),
(
    14,
    'Để kết thúc điểm số ngay',
    0,
    4
),
(
    15,
    'Để đánh lừa đối thủ',
    0,
    4
),
(16, 'Để tiết kiệm sức', 0, 4),

-- Question 5 options
(
    17,
    'Khi đối thủ đứng xa lưới',
    0,
    5
),
(
    18,
    'Khi đối thủ đứng quá gần lưới',
    1,
    5
),
(19, 'Luôn luôn sử dụng', 0, 5),
(
    20,
    'Chỉ trong đánh đơn',
    0,
    5
),

-- Question 6 options
(21, 'Đánh cao hơn', 0, 6),
(22, 'Đánh mạnh hơn', 0, 6),
(
    23,
    'Giữ bóng thấp vào Kitchen',
    1,
    6
),
(
    24,
    'Chỉ đánh cross-court',
    0,
    6
),

-- Question 7 options
(
    25,
    'Một người lưới, một người baseline',
    0,
    7
),
(26, 'Cả hai ở baseline', 0, 7),
(
    27,
    'Cả hai gần Kitchen line',
    1,
    7
),
(
    28,
    'Một người trái, một người phải',
    0,
    7
),

-- Question 8 options
(29, 'Western grip', 0, 8),
(30, 'Eastern grip', 1, 8),
(31, 'Continental grip', 0, 8),
(32, 'Hammer grip', 0, 8),

-- Question 9 options
(
    33,
    'Dùng toàn bộ cánh tay',
    0,
    9
),
(34, 'Chỉ dùng cổ tay', 0, 9),
(35, 'Dùng chân và hông', 1, 9),
(36, 'Nhắm mắt đánh', 0, 9),

-- Question 10 options
(
    37,
    'Làm bóng đi chậm hơn',
    0,
    10
),
(
    38,
    'Làm bóng nảy cao và nhanh',
    1,
    10
),
(
    39,
    'Làm bóng không xoáy',
    0,
    10
),
(40, 'Chỉ để trang trí', 0, 10),

-- Question 11 options
(
    41,
    'Paddle nhẹ (dưới 7.5 oz)',
    0,
    11
),
(
    42,
    'Paddle nặng (trên 8.5 oz)',
    0,
    11
),
(
    43,
    'Paddle trung bình (7.8-8.2 oz)',
    1,
    11
),
(44, 'Không quan trọng', 0, 11),

-- Question 12 options
(45, 'Giống hệt nhau', 0, 12),
(
    46,
    'Bóng ngoài trời nhỏ hơn và nặng hơn',
    1,
    12
),
(
    47,
    'Bóng trong nhà nhỏ hơn',
    0,
    12
),
(48, 'Chỉ khác màu sắc', 0, 12);

-- 9. Sessions
INSERT INTO
    sessions (
        session_id,
        learner_id,
        coach_id,
        datetime,
        status,
        pakage,
        duration_minutes,
        focus_areas,
        notes,
        court_location,
        created_at
    )
VALUES (
        'sess-001',
        'u4-learner-uuid-0000-000000000004',
        'u2-coach-uuid-0000-000000000002',
        '2024-02-10 09:00:00',
        'COMPLETED',
        'PAKAGE_5SESION',
        60,
        'GRIP,BASIC_STROKES,SERVE',
        'Learner showed good progress on forehand technique. Needs work on backhand consistency.',
        'Central Park Pickleball Courts - Court 3',
        NOW()
    ),
    (
        'sess-002',
        'u5-learner-uuid-0000-000000000005',
        'u3-coach-uuid-0000-000000000003',
        '2024-02-11 15:00:00',
        'IN_PROGRESS',
        'PAKAGE_10SESION',
        90,
        'DINK,THIRD_SHOT,FOOTWORK',
        'Working on third shot drop consistency and dinking cross-court.',
        'Sunnyvale Sports Complex',
        NOW()
    ),
    (
        'sess-003',
        'u8-learner-uuid-0000-000000000008',
        'u2-coach-uuid-0000-000000000002',
        '2024-02-12 10:30:00',
        'SCHEDULED',
        'PAKAGE_5SESION',
        60,
        'RULES,BASICS,GRIP',
        'First session - introduction to pickleball.',
        'Community Center Court A',
        NOW()
    ),
    (
        'sess-004',
        'u9-learner-uuid-0000-000000000009',
        'u6-coach-uuid-0000-000000000006',
        '2024-02-13 14:00:00',
        'COMPLETED',
        'PAKAGE_10SESION',
        90,
        'DOUBLES_STRATEGY,COMMUNICATION',
        'Excellent doubles positioning work. Improved poaching skills.',
        'Riverfront Pickleball Club',
        NOW()
    ),
    (
        'sess-005',
        'u10-learner-uuid-0000-0000000010',
        'u7-coach-uuid-0000-000000000007',
        '2024-02-14 16:00:00',
        'CANCELLED',
        'PAKAGE_5SESION',
        60,
        'TOURNAMENT_PREP,MENTAL_GAME',
        'Cancelled due to rain. Rescheduled for next week.',
        'Indoor Sports Arena',
        NOW()
    ),
    (
        'sess-006',
        'u12-learner-uuid-0000-0000000012',
        'u3-coach-uuid-0000-000000000003',
        '2024-02-15 11:00:00',
        'SCHEDULED',
        'PAKAGE_5SESION',
        60,
        'VOLLEY,DINK,CONSISTENCY',
        'Focus on volley technique and dink consistency.',
        'Maple Street Courts',
        NOW()
    ),
    (
        'sess-007',
        'u4-learner-uuid-0000-000000000004',
        'u2-coach-uuid-0000-000000000002',
        '2024-02-17 09:00:00',
        'SCHEDULED',
        'PAKAGE_5SESION',
        60,
        'BACKHAND,FOOTWORK',
        'Continue backhand improvement and add lateral movement drills.',
        'Central Park Pickleball Courts - Court 2',
        NOW()
    ),
    (
        'sess-008',
        'u5-learner-uuid-0000-000000000005',
        'u3-coach-uuid-0000-000000000003',
        '2024-02-18 15:00:00',
        'SCHEDULED',
        'PAKAGE_10SESION',
        90,
        'SPIN,SERVE_VARIATIONS',
        'Adding spin to serves and returns.',
        'Sunnyvale Sports Complex',
        NOW()
    ),
    (
        'sess-009',
        'u11-learner-uuid-0000-0000000011',
        'u6-coach-uuid-0000-000000000006',
        '2024-02-19 13:00:00',
        'SCHEDULED',
        'PAKAGE_5SESION',
        60,
        'BASICS,FIRST_SESSION',
        'Complete beginner - first lesson.',
        'Youth Sports Center',
        NOW()
    ),
    (
        'sess-010',
        'u10-learner-uuid-0000-0000000010',
        'u7-coach-uuid-0000-000000000007',
        '2024-02-20 17:00:00',
        'SCHEDULED',
        'PAKAGE_5SESION',
        60,
        'COMPETITION_DRILLS',
        'High-intensity competition drills.',
        'Pro Training Facility',
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
        method,
        due_date,
        paid_date,
        created_at
    )
VALUES (
        1,
        'u4-learner-uuid-0000-000000000004',
        'u2-coach-uuid-0000-000000000002',
        'sess-001',
        50.00,
        'PAID',
        'CREDIT_CARD',
        '2024-02-11',
        '2024-02-10',
        NOW()
    ),
    (
        2,
        'u5-learner-uuid-0000-000000000005',
        'u3-coach-uuid-0000-000000000003',
        'sess-002',
        75.00,
        'PENDING',
        'BANK_TRANSFER',
        '2024-02-12',
        NULL,
        NOW()
    ),
    (
        3,
        'u9-learner-uuid-0000-000000000009',
        'u6-coach-uuid-0000-000000000006',
        'sess-004',
        80.00,
        'PAID',
        'PAYPAL',
        '2024-02-14',
        '2024-02-13',
        NOW()
    ),
    (
        4,
        'u8-learner-uuid-0000-000000000008',
        'u2-coach-uuid-0000-000000000002',
        'sess-003',
        50.00,
        'PENDING',
        'CREDIT_CARD',
        '2024-02-13',
        NULL,
        NOW()
    ),
    (
        5,
        'u4-learner-uuid-0000-000000000004',
        'u2-coach-uuid-0000-000000000002',
        'sess-007',
        50.00,
        'PENDING',
        'BANK_TRANSFER',
        '2024-02-18',
        NULL,
        NOW()
    ),
    (
        6,
        'u5-learner-uuid-0000-000000000005',
        'u3-coach-uuid-0000-000000000003',
        'sess-008',
        75.00,
        'PENDING',
        'CREDIT_CARD',
        '2024-02-19',
        NULL,
        NOW()
    ),
    (
        7,
        'u12-learner-uuid-0000-0000000012',
        'u3-coach-uuid-0000-000000000003',
        'sess-006',
        50.00,
        'PAID',
        'PAYPAL',
        '2024-02-16',
        '2024-02-15',
        NOW()
    ),
    (
        8,
        'u11-learner-uuid-0000-0000000011',
        'u6-coach-uuid-0000-000000000006',
        'sess-009',
        60.00,
        'PENDING',
        'BANK_TRANSFER',
        '2024-02-20',
        NULL,
        NOW()
    ),
    (
        9,
        'u10-learner-uuid-0000-0000000010',
        'u7-coach-uuid-0000-000000000007',
        'sess-010',
        60.00,
        'PENDING',
        'CREDIT_CARD',
        '2024-02-21',
        NULL,
        NOW()
    );

-- Display completion message
SELECT 'Seed data inserted successfully!' AS message;

SELECT
    COUNT(*) as total_users,
    (
        SELECT COUNT(*)
        FROM coaches
    ) as total_coaches,
    (
        SELECT COUNT(*)
        FROM learners
    ) as total_learners,
    (
        SELECT COUNT(*)
        FROM courses
    ) as total_courses,
    (
        SELECT COUNT(*)
        FROM modules
    ) as total_modules,
    (
        SELECT COUNT(*)
        FROM lessons
    ) as total_lessons,
    (
        SELECT COUNT(*)
        FROM question
    ) as total_questions,
    (
        SELECT COUNT(*)
        FROM sessions
    ) as total_sessions,
    (
        SELECT COUNT(*)
        FROM debts
    ) as total_debts
FROM users;

SET FOREIGN_KEY_CHECKS = 1;