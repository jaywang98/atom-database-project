/*
Navicat MySQL Data Transfer

Source Server         : 实验
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : movie_recommend_db

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2020-05-28 09:57:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2020-04-18 08:09:09.863652');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2020-04-18 08:09:11.333122');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2020-04-18 08:09:11.550106');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2020-04-18 08:09:11.562074');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2020-04-18 08:09:11.679760');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0px5zizwags3cvp9qhycy9n00pxkbix0', 'OTFhNDVjZGU2ZWQ4MTg4ZGM0ZDNlNWQ3NTNiMmQzNTYwNWU5OGZkYzp7InVzZXJfaWQiOjEsIl9zZXNzaW9uX2V4cGlyeSI6LTF9', '2020-04-22 11:48:05.012159');
INSERT INTO `django_session` VALUES ('52pk40s1w1smwej2erjni1t0o1g1euqj', 'OTFhNDVjZGU2ZWQ4MTg4ZGM0ZDNlNWQ3NTNiMmQzNTYwNWU5OGZkYzp7InVzZXJfaWQiOjEsIl9zZXNzaW9uX2V4cGlyeSI6LTF9', '2020-04-24 06:51:01.858579');
INSERT INTO `django_session` VALUES ('5odw37f3vwbi2d35q1qer4udih7tfgyg', 'ZWFiY2Y1ODNiMGI2MmE3MDMwZjU0NjhmOTMyYWFlYzcyMjBhYThhODp7InVzZXJfaWQiOjE0NiwiX3Nlc3Npb25fZXhwaXJ5IjotMX0=', '2020-04-25 11:01:12.421961');
INSERT INTO `django_session` VALUES ('5p7wq14p42it9eo3y9a4ci1wk63wweze', 'OTFhNDVjZGU2ZWQ4MTg4ZGM0ZDNlNWQ3NTNiMmQzNTYwNWU5OGZkYzp7InVzZXJfaWQiOjEsIl9zZXNzaW9uX2V4cGlyeSI6LTF9', '2020-04-24 01:30:10.424223');
INSERT INTO `django_session` VALUES ('d5c78sgk24azutaqdn6yhfr9lr5c3oc3', 'OTFhNDVjZGU2ZWQ4MTg4ZGM0ZDNlNWQ3NTNiMmQzNTYwNWU5OGZkYzp7InVzZXJfaWQiOjEsIl9zZXNzaW9uX2V4cGlyeSI6LTF9', '2020-04-25 10:58:53.110680');

-- ----------------------------
-- Table structure for genre
-- ----------------------------
DROP TABLE IF EXISTS `genre`;
CREATE TABLE `genre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of genre
-- ----------------------------
INSERT INTO `genre` VALUES ('1', 'Musical');
INSERT INTO `genre` VALUES ('2', 'War');
INSERT INTO `genre` VALUES ('3', 'Crime');
INSERT INTO `genre` VALUES ('4', 'Romance');
INSERT INTO `genre` VALUES ('5', 'Fantasy');


-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `imdb_id` int(11) NOT NULL,
  `release_time` varchar(256) NOT NULL,
  `intro` longtext NOT NULL,
  `director` varchar(256) NOT NULL,
  `writers` varchar(256) NOT NULL,
  `actors` varchar(512) NOT NULL,
  `time` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26533 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO `movie` VALUES ('16791', 'Toy Story (1995) ', '1', '22 November 1995 (USA)', 'A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy\'s room.', 'John Lasseter', 'John Lasseter|Pete Docter', 'Tom Hanks|Tim Allen|Don Rickles', '1h 21min');
INSERT INTO `movie` VALUES ('16792', 'Jumanji (1995) ', '2', '15 December 1995 (USA)', 'When two kids find and play a magical board game, they release a man trapped in it for decades--and a host of dangers that can only be stopped by finishing the game.', 'Joe Johnston', 'Jonathan Hensleigh|Greg Taylor', 'Robin Williams|Kirsten Dunst|Bonnie Hunt', '1h 44min');
INSERT INTO `movie` VALUES ('16793', 'Grumpier Old Men (1995) ', '3', '22 December 1995 (USA)', 'John and Max resolve to save their beloved bait shop from turning into an Italian restaurant, just as its new female owner catches Max\'s attention.', 'Howard Deutch', 'Mark Steven Johnson', 'Walter Matthau|Jack Lemmon|Ann-Margret', '1h 41min');
INSERT INTO `movie` VALUES ('16794', 'Waiting to Exhale (1995) ', '4', '22 December 1995 (USA)', 'Based on Terry McMillan\'s novel, this film follows four very different African-American women and their relationships with the male gender.', 'Forest Whitaker', 'Terry McMillan|Terry McMillan', 'Whitney Houston|Angela Bassett|Loretta Devine', '2h 4min');
INSERT INTO `movie` VALUES ('16795', 'Father of the Bride Part II (1995) ', '5', '8 December 1995 (USA)', 'George Banks must deal not only with the pregnancy of his daughter, but also with the unexpected pregnancy of his wife.', 'Charles Shyer', 'Albert Hackett|Frances Goodrich', 'Steve Martin|Diane Keaton|Martin Short', '1h 46min');

-- ----------------------------
-- Table structure for movie_genre
-- ----------------------------
DROP TABLE IF EXISTS `movie_genre`;
CREATE TABLE `movie_genre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Movie_genre_movie_id_genre_id_b71432d5_uniq` (`movie_id`,`genre_id`),
  KEY `Movie_genre_genre_id_776f09a0_fk_Genre_id` (`genre_id`),
  CONSTRAINT `Movie_genre_genre_id_776f09a0_fk_Genre_id` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`),
  CONSTRAINT `Movie_genre_movie_id_be61d94f_fk_Movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65891 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movie_genre
-- ----------------------------
INSERT INTO `movie_genre` VALUES ('41666', '16791', '10');
INSERT INTO `movie_genre` VALUES ('41664', '16791', '17');
INSERT INTO `movie_genre` VALUES ('41665', '16791', '18');
INSERT INTO `movie_hot` VALUES ('698', '115', '20950');
INSERT INTO `movie_hot` VALUES ('699', '113', '18236');

-- ----------------------------
-- Table structure for movie_movie_similarity
-- ----------------------------
DROP TABLE IF EXISTS `movie_movie_similarity`;
CREATE TABLE `movie_movie_similarity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `similarity` double NOT NULL,
  `movie_source_id` int(11) NOT NULL,
  `movie_target_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_movie_similarity_movie_source_id_425abe2d_fk_Movie_id` (`movie_source_id`),
  KEY `movie_movie_similarity_movie_target_id_7e48b00a_fk_Movie_id` (`movie_target_id`),
  CONSTRAINT `movie_movie_similarity_movie_source_id_425abe2d_fk_Movie_id` FOREIGN KEY (`movie_source_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `movie_movie_similarity_movie_target_id_7e48b00a_fk_Movie_id` FOREIGN KEY (`movie_target_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97301 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movie_movie_similarity
-- ----------------------------
INSERT INTO `movie_movie_similarity` VALUES ('1', '0.585416442181086', '16791', '17406');
INSERT INTO `movie_movie_similarity` VALUES ('2', '0.583534076777862', '16791', '17209');
INSERT INTO `movie_movie_similarity` VALUES ('3', '0.579033301781507', '16791', '17105');
INSERT INTO `movie_movie_similarity` VALUES ('4', '0.576831153424315', '16791', '17015');
INSERT INTO `movie_movie_similarity` VALUES ('95755', '1', '21617', '20929');

-- ----------------------------
-- Table structure for movie_rating
-- ----------------------------
DROP TABLE IF EXISTS `movie_rating`;
CREATE TABLE `movie_rating` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` double NOT NULL,
  `comment` longtext NOT NULL,
  `movie_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Movie_rating_movie_id_a6859c17_fk_Movie_id` (`movie_id`),
  KEY `Movie_rating_user_id_1b361a26_fk_User_id` (`user_id`),
  CONSTRAINT `Movie_rating_movie_id_a6859c17_fk_Movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `Movie_rating_user_id_1b361a26_fk_User_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=322001 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movie_rating
-- ----------------------------
INSERT INTO `movie_rating` VALUES ('221143', '4', '', '16791', '146');
INSERT INTO `movie_rating` VALUES ('221144', '4', '', '16793', '146');
INSERT INTO `movie_rating` VALUES ('221145', '4', '', '16796', '146');
INSERT INTO `movie_rating` VALUES ('221146', '5', '', '16834', '146');
INSERT INTO `movie_rating` VALUES ('221147', '5', '', '16837', '146');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'hmy', '123', '13163369616@163.com');
INSERT INTO `user` VALUES ('146', '1', '1', '1@1.com');
INSERT INTO `user` VALUES ('147', '2', '2', '2@1.com');
INSERT INTO `user` VALUES ('148', '3', '3', '3@1.com');
INSERT INTO `user` VALUES ('149', '4', '4', '4@1.com');
