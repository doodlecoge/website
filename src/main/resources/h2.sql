DROP SCHEMA IF EXISTS website;
CREATE SCHEMA website;


CREATE TABLE website.users
(
  username   VARCHAR(20) NOT NULL PRIMARY KEY,
  password   VARCHAR(20) NOT NULL,
  fullname   VARCHAR(20) NULL,
  photo      VARCHAR(24) NULL, -- <username> "." <ext>
  role       VARCHAR(8)  NOT NULL DEFAULT 'USER', -- "user" | "admin"
  created_at TIMESTAMP   NOT NULL
);

INSERT INTO website.users
(username, password, fullname, photo, role, created_at)
VALUES
  ('huaichao', 'pass1234', 'Huaichao Wang', NULL, 'ADMIN', '2014-11-29'),
  ('chaochao', 'pass1234', 'Chaochao Wang', NULL, 'USER', '2014-11-29');

CREATE TABLE website.tags
(
  id   INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL UNIQUE
);

INSERT INTO website.tags (id, name)
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

CREATE TABLE website.logos
(
  id          INT AUTO_INCREMENT PRIMARY KEY,
  description VARCHAR(64) NOT NULL,
  path        VARCHAR(82) NULL
);

CREATE TABLE website.articles
(
  id         INT AUTO_INCREMENT PRIMARY KEY,
  title      VARCHAR(200)  NOT NULL,
  content    VARCHAR(4096) NOT NULL,
  username   VARCHAR(20)   NOT NULL,
  created_at DATETIME      NOT NULL,
  updated_at DATETIME      NOT NULL,
  logo_id    INT           NULL,
  FOREIGN KEY (username) REFERENCES users (username),
  FOREIGN KEY (logo_id) REFERENCES logos (id)
);

INSERT INTO website.articles
(id, title, content, username, created_at, updated_at)
VALUES
  (1, 'spring security', '1 content', 'huaichao', '2014-11-29', '2014-11-29'),
  (2, 'c/c++          ', '2 content', 'chaochao', '2014-11-29', '2014-11-29'),
  (3, 'sed command    ', '3 content', 'huaichao', '2014-11-29', '2014-11-29'),
  (4, 'java reflection', '4 content', 'huaichao', '2014-11-29', '2014-11-29'),
  (5, 'python network ', '5 content', 'huaichao', '2014-11-29', '2014-11-29');

CREATE TABLE website.articles_tags
(
  aid INT NOT NULL,
  tid INT NOT NULL,
  PRIMARY KEY (aid, tid),
  FOREIGN KEY (aid) REFERENCES articles (id)
  ON DELETE CASCADE,
  FOREIGN KEY (tid) REFERENCES tags (id)
  ON DELETE CASCADE
);

INSERT INTO website.articles_tags
(aid, tid)
VALUES
  (1, 1),
  (1, 2),
  (1, 6),
  (2, 1),
  (2, 5),
  (2, 6),
  (2, 9);
