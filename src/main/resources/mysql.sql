DROP DATABASE IF EXISTS website;

CREATE DATABASE website;

GRANT ALL PRIVILEGES ON website.*
TO 'huaichao'@'%'
IDENTIFIED BY 'password';

FLUSH PRIVILEGES;

USE website;

CREATE TABLE users
(
  username   VARCHAR(20) NOT NULL PRIMARY KEY,
  password   VARCHAR(20) NOT NULL,
  fullname   VARCHAR(20) NULL,
  photo      VARCHAR(24) NULL, -- <username> "." <ext>
  role       VARCHAR(8)  NOT NULL DEFAULT 'USER', -- "user" | "admin"
  created_at TIMESTAMP   NOT NULL
);

INSERT INTO users
(username, password, fullname, photo, role, created_at)
VALUES
  ('huaichao', 'pass1234', 'Huaichao Wang', NULL, 'ADMIN', '2014-11-29'),
  ('chaochao', 'pass1234', 'Chaochao Wang', NULL, 'USER', '2014-11-29');

CREATE TABLE tags
(
  id   INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL UNIQUE
);

INSERT INTO tags (id, name)
VALUES
  (1, 'hibernate'),
  (2, 'java'),
  (3, 'javascript'),
  (4, 'c/c++'),
  (5, 'spring'),
  (6, 'struts'),
  (7, 'vb'),
  (8, 'c#'),
  (9, 'python');

CREATE TABLE logos
(
  id   INT AUTO_INCREMENT PRIMARY KEY,
  description VARCHAR(64) NOT NULL,
  path  VARCHAR(82) NULL
);

CREATE TABLE articles
(
  id         INT AUTO_INCREMENT PRIMARY KEY,
  title      VARCHAR(200)  NOT NULL,
  content    VARCHAR(4096) NOT NULL,
  username   VARCHAR(20)   NOT NULL,
  created_at DATETIME      NOT NULL,
  updated_at DATETIME      NOT NULL,
  logo_id int null,
  FOREIGN KEY (username) REFERENCES users (username),
  foreign key (logo_id) references logos(id)
);

INSERT INTO articles
(id, title, content, username, created_at, updated_at)
VALUES
  (1, 'spring security', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (2, 'c/c++          ', '', 'chaochao', '2014-11-29', '2014-11-29'),
  (3, 'sed command    ', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (4, 'java reflection', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (5, 'python network ', '', 'huaichao', '2014-11-29', '2014-11-29');

CREATE TABLE articles_tags
(
  aid INT NOT NULL,
  tid INT NOT NULL,
  PRIMARY KEY (aid, tid),
  FOREIGN KEY (aid) REFERENCES articles (id)
    ON DELETE CASCADE,
  FOREIGN KEY (tid) REFERENCES tags (id)
    ON DELETE CASCADE
);

INSERT INTO articles_tags
(aid, tid)
VALUES
  (1, 1),
  (1, 2),
  (1, 6),
  (2, 1),
  (2, 5),
  (2, 6),
  (2, 9);
