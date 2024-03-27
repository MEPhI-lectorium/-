-- Создание БД lectorium
-- CREATE DATABASE lectorium;
USE lectorium;
-- Создание таблицы "User"
CREATE TABLE User (
                      user_id INT PRIMARY KEY,
                      first_name VARCHAR(50),
                      last_name VARCHAR(50),
                      middle_name VARCHAR(50),
                      email VARCHAR(100),
                      password VARCHAR(100),
                      role VARCHAR(50),
                      is_student_mifi BOOLEAN,
                      university VARCHAR(100),
                      faculty VARCHAR(100),
                      group_name VARCHAR(50),
                      two_factor_auth_enabled BOOLEAN
);

-- Создание таблицы "Authorization"
CREATE TABLE Authorization (
                               auth_id INT PRIMARY KEY,
                               user_id INT,
                               token VARCHAR(100),
                               two_factor_enabled BOOLEAN,
                               FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Создание таблицы "Lecture"
CREATE TABLE Lecture (
                         lecture_id INT PRIMARY KEY,
                         lecturer_id INT,
                         title VARCHAR(100),
                         description TEXT,
                         date DATE,
                         summary_id INT,
                         forum_id INT,
                         FOREIGN KEY (lecturer_id) REFERENCES User(user_id),
                         FOREIGN KEY (summary_id) REFERENCES Summary(summary_id),
                         FOREIGN KEY (forum_id) REFERENCES Forum(forum_id)
);

-- Создание таблицы "Summary"
CREATE TABLE Summary (
                         summary_id INT PRIMARY KEY,
                         title VARCHAR(100),
                         description TEXT
);

-- Создание таблицы "Files"
CREATE TABLE Files (
                       file_id INT PRIMARY KEY,
                       file_path VARCHAR(255),
                       lecture_id INT,
                       FOREIGN KEY (lecture_id) REFERENCES Lecture(lecture_id)
);

-- Создание таблицы "Forum"
CREATE TABLE Forum (
                       forum_id INT PRIMARY KEY,
                       title VARCHAR(100),
                       description TEXT
);

-- Создание таблицы "Forum Topics"
CREATE TABLE Forum_Topics (
                              topic_id INT PRIMARY KEY,
                              forum_id INT,
                              title VARCHAR(100),
                              description TEXT,
                              FOREIGN KEY (forum_id) REFERENCES Forum(forum_id)
);

-- Создание таблицы "Forum Messages"
CREATE TABLE Forum_Messages (
                                message_id INT PRIMARY KEY,
                                topic_id INT,
                                user_id INT,
                                message_text TEXT,
                                timestamp TIMESTAMP,
                                reply_id INT,
                                FOREIGN KEY (topic_id) REFERENCES Forum_Topics(topic_id),
                                FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Создание таблицы "Forum Participants"
CREATE TABLE Forum_Participants (
                                    participant_id INT PRIMARY KEY,
                                    forum_id INT,
                                    user_id INT,
                                    FOREIGN KEY (forum_id) REFERENCES Forum(forum_id),
                                    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Создание таблицы "Forum Participants Roles"
CREATE TABLE Forum_Participants_Roles (
                                          role_id INT PRIMARY KEY,
                                          participant_id INT,
                                          role_name VARCHAR(50),
                                          FOREIGN KEY (participant_id) REFERENCES Forum_Participants(participant_id)
);
