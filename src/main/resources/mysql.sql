-- ver 1.0

CREATE DATABASE IF NOT EXISTS website;

USE website;


CREATE TABLE IF NOT EXISTS users
(
  username   VARCHAR(20) NOT NULL PRIMARY KEY,
  password   VARCHAR(20) NOT NULL,
  fullname   VARCHAR(20) NULL,
  photo      VARCHAR(24) NULL, -- <username> "." <ext>
  role       VARCHAR(8)  NOT NULL DEFAULT 'USER', -- "user" | "admin"
  created_at TIMESTAMP   NOT NULL
);


CREATE TABLE IF NOT EXISTS tags
(
  id   INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS logos
(
  id          INT AUTO_INCREMENT PRIMARY KEY,
  description VARCHAR(64) NOT NULL,
  path        VARCHAR(82) NULL
);


CREATE TABLE IF NOT EXISTS articles
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


CREATE TABLE IF NOT EXISTS articles_tags
(
  aid INT NOT NULL,
  tid INT NOT NULL,
  PRIMARY KEY (aid, tid),
  FOREIGN KEY (aid) REFERENCES articles (id)
    ON DELETE CASCADE,
  FOREIGN KEY (tid) REFERENCES tags (id)
    ON DELETE CASCADE
);
