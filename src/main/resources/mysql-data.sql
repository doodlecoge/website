use website;


INSERT INTO users
(username, password, fullname, photo, role, created_at)
VALUES
  ('huaichao', 'pass1234', 'Huaichao Wang', NULL, 'ADMIN', '2014-11-29'),
  ('chaochao', 'pass1234', 'Chaochao Wang', NULL, 'USER', '2014-11-29');


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


INSERT INTO articles
(id, title, content, username, created_at, updated_at)
VALUES
  (1, 'spring security', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (2, 'c/c++          ', '', 'chaochao', '2014-11-29', '2014-11-29'),
  (3, 'sed command    ', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (4, 'java reflection', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (5, 'python network ', '', 'huaichao', '2014-11-29', '2014-11-29');


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
