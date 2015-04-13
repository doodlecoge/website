INSERT INTO website.users
(username, password, fullname, photo, role, created_at)
VALUES
  ('huaichao', 'pass1234', 'Huaichao Wang', NULL, 'ADMIN', '2014-11-29'),
  ('chaochao', 'pass1234', 'Chaochao Wang', NULL, 'USER', '2014-11-29');


INSERT INTO website.tags (id, name)
VALUES
  (01, 'hibernate'),
  (02, 'java'),
  (03, 'javascript'),
  (04, 'c/c++'),
  (05, 'spring'),
  (06, 'struts'),
  (07, 'vb'),
  (08, 'c#'),
  (09, 'python'),
  (10, 'shell'),
  (11, 'jdbc'),
  (12, 'oracle'),
  (13, 'obj-c'),
  (14, 'android'),
  (15, 'tcp/udp');


INSERT INTO website.articles
(id, title, content, username, created_at, updated_at)
VALUES
  (1, 'spring security', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (2, 'c/c++          ', '', 'chaochao', '2014-11-29', '2014-11-29'),
  (3, 'sed command    ', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (4, 'java reflection', '', 'huaichao', '2014-11-29', '2014-11-29'),
  (5, 'python network ', '', 'huaichao', '2014-11-29', '2014-11-29');


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
