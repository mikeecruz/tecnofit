/*
 Navicat Premium Dump SQL

 Source Server         : Local Docker
 Source Server Type    : MySQL
 Source Server Version : 90001 (9.0.1)
 Source Host           : localhost:3306
 Source Schema         : tecnofit

 Target Server Type    : MySQL
 Target Server Version : 90001 (9.0.1)
 File Encoding         : 65001

 Date: 02/09/2024 19:53:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for movement
-- ----------------------------
DROP TABLE IF EXISTS `movement`;
CREATE TABLE `movement`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movement
-- ----------------------------
INSERT INTO `movement` VALUES (1, 'Deadlift');
INSERT INTO `movement` VALUES (2, 'Back Squat');
INSERT INTO `movement` VALUES (3, 'Bench Press');

-- ----------------------------
-- Table structure for personal_record
-- ----------------------------
DROP TABLE IF EXISTS `personal_record`;
CREATE TABLE `personal_record`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `movement_id` int NOT NULL,
  `value` float NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `personal_record_fk0`(`user_id` ASC) USING BTREE,
  INDEX `personal_record_fk1`(`movement_id` ASC) USING BTREE,
  CONSTRAINT `personal_record_fk0` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `personal_record_fk1` FOREIGN KEY (`movement_id`) REFERENCES `movement` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_record
-- ----------------------------
INSERT INTO `personal_record` VALUES (1, 1, 1, 100, '2021-01-01 00:00:00');
INSERT INTO `personal_record` VALUES (2, 1, 1, 180, '2021-01-02 00:00:00');
INSERT INTO `personal_record` VALUES (3, 1, 1, 150, '2021-01-03 00:00:00');
INSERT INTO `personal_record` VALUES (4, 1, 1, 110, '2021-01-04 00:00:00');
INSERT INTO `personal_record` VALUES (5, 2, 1, 110, '2021-01-04 00:00:00');
INSERT INTO `personal_record` VALUES (6, 2, 1, 140, '2021-01-05 00:00:00');
INSERT INTO `personal_record` VALUES (7, 2, 1, 190, '2021-01-06 00:00:00');
INSERT INTO `personal_record` VALUES (8, 3, 1, 170, '2021-01-01 00:00:00');
INSERT INTO `personal_record` VALUES (9, 3, 1, 120, '2021-01-02 00:00:00');
INSERT INTO `personal_record` VALUES (10, 3, 1, 130, '2021-01-03 00:00:00');
INSERT INTO `personal_record` VALUES (11, 1, 2, 130, '2021-01-03 00:00:00');
INSERT INTO `personal_record` VALUES (12, 2, 2, 130, '2021-01-03 00:00:00');
INSERT INTO `personal_record` VALUES (13, 3, 2, 125, '2021-01-03 00:00:00');
INSERT INTO `personal_record` VALUES (14, 1, 2, 110, '2021-01-05 00:00:00');
INSERT INTO `personal_record` VALUES (15, 1, 2, 100, '2021-01-01 00:00:00');
INSERT INTO `personal_record` VALUES (16, 2, 2, 120, '2021-01-01 00:00:00');
INSERT INTO `personal_record` VALUES (17, 3, 2, 120, '2021-01-01 00:00:00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Joao');
INSERT INTO `user` VALUES (2, 'Jose');
INSERT INTO `user` VALUES (3, 'Paulo');

SET FOREIGN_KEY_CHECKS = 1;
