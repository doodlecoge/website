-- ver 1.0

CREATE DATABASE IF NOT EXISTS website
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;


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


CREATE TABLE IF NOT EXISTS images
(
  id         INT AUTO_INCREMENT PRIMARY KEY,
  dirname    VARCHAR(10), -- yyyy-MM-dd
  filename   VARCHAR(100),
  username   VARCHAR(20),
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (username) REFERENCES users (username)
    ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS articles
(
  id         INT AUTO_INCREMENT PRIMARY KEY,
  title      VARCHAR(200)  NOT NULL,
  content    VARCHAR(4096) NOT NULL,
  username   VARCHAR(20)   NOT NULL,
  created_at DATETIME      NOT NULL,
  updated_at DATETIME      NOT NULL,
  image_id   INT           NULL,
  FOREIGN KEY (username) REFERENCES users (username),
  FOREIGN KEY (image_id) REFERENCES images (id)
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

