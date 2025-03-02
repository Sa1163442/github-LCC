/*
 Navicat Premium Dump SQL

 Source Server         : myConnection
 Source Server Type    : MySQL
 Source Server Version : 80400 (8.4.0)
 Source Host           : localhost:3306
 Source Schema         : camp

 Target Server Type    : MySQL
 Target Server Version : 80400 (8.4.0)
 File Encoding         : 65001

 Date: 28/02/2025 01:02:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `issue_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id` DESC) USING BTREE,
  INDEX `fk2`(`issue_id` ASC) USING BTREE,
  INDEX `fk3`(`user_id` ASC) USING BTREE,
  CONSTRAINT `k2` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `k3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 191 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (190, 175, 10, 'Fatigue is hitting hard, we might need to cut the trip short if it doesn’t improve.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (189, 175, 8, 'Some campers are really fatigued and unable to continue. This is a serious problem.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (188, 174, 1, 'Water supply is scarce and we’re getting concerned about running out.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (187, 174, 7, 'We’re running low on water, this is a critical issue for survival.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (186, 173, 8, 'Without proper maps, we’re essentially walking blindfolded. It’s frustrating.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (185, 173, 6, 'Lack of maps is making it difficult to plan our route. We need to get some.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (184, 172, 2, 'Starting a fire in wet conditions is nearly impossible without proper tools.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (183, 172, 5, 'Fire is hard to start because of the wet conditions. We need better fire starters.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (182, 171, 6, 'There’s too much uncertainty with wild plant identification. We need a guide for this.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (181, 171, 1, 'We need to be sure about which wild plants are safe to eat before we consume anything.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (180, 170, 9, 'My backpack is falling apart, the straps broke on the second day of hiking!', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (179, 170, 4, 'The backpack straps broke during the hike, totally unacceptable.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (178, 169, 7, 'Rain jackets are supposed to keep us dry but they’re leaking everywhere!', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (177, 169, 3, 'The rain jackets are not waterproof, I’m getting soaked and cold.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (176, 168, 5, 'Not enough light to safely move around at night. We need to invest in better lighting.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (175, 168, 2, 'It’s pitch dark here at night, we definitely need more lighting around the campsite.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (174, 167, 1, 'We need to figure out what caused the food poisoning and make sure it doesn’t spread.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (173, 167, 10, 'Food poisoning is hitting a few people in our group, we need to address this urgently.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (172, 166, 4, 'Our tent kept falling over, it’s really bad quality and unsafe.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (171, 166, 9, 'The tent is unstable and difficult to set up, we need to replace it.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (170, 165, 3, 'I lost track of where I was supposed to go with the broken compass, this is dangerous.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (169, 165, 8, 'The compass is broken, and we’re having trouble navigating without it.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (168, 164, 2, 'It’s tough to cook without a fire, these local regulations are a real hassle.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (167, 164, 7, 'Cooking fire restrictions are frustrating, we need fire for cooking and warmth.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (166, 163, 10, 'It’s overcrowded here. The campsite is too small for all of us.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (165, 163, 6, 'The campsite is too small, not enough room for everyone to sleep comfortably.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (164, 162, 8, 'We can’t even enjoy the fire because of all the smoke. It’s causing discomfort.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (163, 162, 5, 'The excessive smoke from the fire is unbearable. It’s making everyone uncomfortable.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (162, 161, 7, 'In case of an emergency, we’re stuck with no way to communicate outside.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (161, 161, 4, 'No cell service, we can’t make emergency calls. This is a safety issue.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (160, 160, 6, 'The trail signs are too vague, we need better markers to avoid getting lost.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (159, 160, 3, 'Trail signage is really lacking, we got lost a few times looking for the right path.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (158, 159, 9, 'Freezing at night, my sleeping bag isn’t warm enough to handle this cold.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (157, 159, 2, 'Sleeping bags are insufficient, they don’t provide warmth in cold nights.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (156, 158, 4, 'Cooking stove isn’t working as expected, needs immediate repair or replacement.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (155, 158, 1, 'The cooking equipment malfunctioned and delayed our meal time, not acceptable.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (154, 157, 3, 'Insects are a big issue, the repellent is doing nothing.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (153, 157, 10, 'Insect repellent doesn’t work at all, I’ve been bitten all over.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (152, 156, 2, 'Severe weather warnings are worrying, we might need to evacuate soon.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (151, 156, 9, 'Bad weather is expected, better stay prepared for rain and strong winds.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (150, 155, 10, 'Drinking unsafe water is a health risk, this water purification issue is serious.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (149, 155, 8, 'The water purification tablets aren’t working, we need a new solution for clean water.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (148, 154, 8, 'Navigation is tough without a working GPS signal, this needs fixing.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (147, 154, 6, 'Lost GPS signal, really hard to navigate in the forest without it.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (146, 153, 7, 'The food spoilage issue is becoming a major concern. We should have prepared better.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (145, 153, 3, 'Food is going bad, we need better storage methods to preserve it!', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (144, 152, 10, 'A missing first aid kit can be dangerous, especially in remote areas.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (143, 152, 5, 'First aid kit is definitely missing some crucial items, need to check it before the trip.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (142, 151, 6, 'Ran out of firewood, we had to improvise. Not ideal for camping.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (141, 151, 4, 'Firewood shortage is a big deal, we need to make sure we have enough for cooking.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (140, 150, 9, 'Wildlife encounters are getting out of hand, I’m worried for safety.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (139, 150, 7, 'Had some close encounters with wildlife, need better protection or deterrents!', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (138, 149, 5, 'Seems like we are missing some key supplies for cooking, not ideal for a camping trip.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (137, 149, 2, 'Missing supplies is an issue that needs to be addressed right away.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (136, 148, 3, 'Haven’t had any issues with leaks in my tent, but it’s a serious problem for others.', '2025-02-27 22:14:11');
INSERT INTO `comments` VALUES (135, 148, 1, 'The tent leakage issue is a major concern, needs immediate fixing!', '2025-02-27 22:14:11');

-- ----------------------------
-- Table structure for issues
-- ----------------------------
DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues`  (
  `issue_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('new','open','stalled','resolved') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`issue_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `k1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of issues
-- ----------------------------
INSERT INTO `issues` VALUES (148, 1, 'Tent leakage', 'The tent has multiple leaks during rain.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (149, 2, 'Missing supplies', 'User reported missing cooking supplies.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (150, 3, 'Wildlife encounters', 'Unwanted wildlife visited the campsite at night.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (151, 4, 'Firewood shortage', 'Not enough firewood available for cooking.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (152, 5, 'First aid kit issues', 'First aid kit is missing essential items.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (153, 6, 'Inadequate food storage', 'Food is spoiling due to poor storage methods.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (154, 7, 'Navigation problems', 'Lost GPS signal in the forest.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (155, 8, 'Water purification failure', 'Water purification tablets are ineffective.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (156, 9, 'Bad weather warning', 'Severe weather warnings issued for the area.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (157, 10, 'Insect repellent ineffective', 'Insect repellent not working, many bites.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (158, 1, 'Cooking equipment malfunction', 'Camping stove not working properly.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (159, 2, 'Insufficient warmth', 'Sleeping bags not keeping warm during the night.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (160, 3, 'Trail signage missing', 'Difficulty in finding the right trail due to missing signs.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (161, 4, 'Emergency communication failure', 'No cell service for emergency calls.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (162, 5, 'Excessive smoke from fire', 'Fire produces too much smoke, causing discomfort.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (163, 6, 'Limited campsite space', 'Campsite is too small for the group.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (164, 7, 'Cooking fire restrictions', 'Local regulations restrict open fires.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (165, 8, 'Navigation tool failure', 'Compass is not working correctly.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (166, 9, 'Shelter instability', 'Tent is unstable and hard to set up.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (167, 10, 'Food poisoning', 'Some campers experienced food poisoning.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (168, 1, 'Insufficient lighting', 'Not enough lights for night activities.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (169, 2, 'Weather gear inadequate', 'Rain jackets are not waterproof enough.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (170, 3, 'Broken backpack straps', 'Backpack straps broke during the hike.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (171, 4, 'Wild plant identification', 'Uncertainty about safe wild plants to eat.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (172, 5, 'Fire starting challenges', 'Difficulty starting a fire in wet conditions.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (173, 6, 'Lack of maps', 'No maps available for the hiking area.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (174, 7, 'Inadequate water supply', 'Users running low on drinking water.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (175, 8, 'Fatigue issues', 'Some campers are feeling fatigued and unable to continue.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (176, 9, 'Unhygienic conditions', 'Campsite is not clean, attracting pests.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (177, 10, 'Limited outdoor gear', 'Not enough outdoor gear for all participants.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (178, 1, 'Emergency shelter needed', 'Need to build an emergency shelter quickly.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (179, 2, 'Difficulty setting up tents', 'Tents are complicated to set up in the dark.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (180, 3, 'Lack of cooking knowledge', 'Some campers lack cooking skills.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (181, 4, 'Overpacking issues', 'Some campers brought too much unnecessary gear.', '2025-02-27 22:04:44', 'open');
INSERT INTO `issues` VALUES (182, 5, 'Unreliable weather forecasts', 'Weather forecasts have been inaccurate.', '2025-02-27 22:04:44', 'stalled');
INSERT INTO `issues` VALUES (183, 6, 'Fatigue from hiking', 'Hikers are struggling with exhaustion.', '2025-02-27 22:04:44', 'resolved');
INSERT INTO `issues` VALUES (184, 7, 'Campsite safety concerns', 'Concerns about safety in the camping area.', '2025-02-27 22:04:44', 'new');
INSERT INTO `issues` VALUES (185, 8, 'Limited communication', 'Group members are scattered and can’t communicate.', '2025-02-27 22:04:44', 'open');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(320) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `profile_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` enum('visitor','helper','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id` DESC) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (59, 'Alexander Clark', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Alexander', 'Clark', 'Miami', '', 'admin', 'inactive');
INSERT INTO `users` VALUES (58, 'Hannah Evans', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Hannah', 'Evans', 'Denver', '', 'visitor', 'active');
INSERT INTO `users` VALUES (57, 'Lucas Miller', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Lucas', 'Miller', 'Portland', '', 'admin', 'inactive');
INSERT INTO `users` VALUES (56, 'Olivia Williams', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Olivia', 'Williams', 'Seattle', '', 'helper', 'active');
INSERT INTO `users` VALUES (55, 'Steven Jackson', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Steven', 'Jackson', 'Boston', '', 'visitor', 'active');
INSERT INTO `users` VALUES (54, 'Mary Anderson', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Mary', 'Anderson', 'Atlanta', '', 'admin', 'inactive');
INSERT INTO `users` VALUES (53, 'Charles Martin', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Charles', 'Martin', 'Miami', '', 'helper', 'active');
INSERT INTO `users` VALUES (52, 'Susan Moore', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Susan', 'Moore', 'Las Vegas', '', 'visitor', 'active');
INSERT INTO `users` VALUES (51, 'Mark Lee', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Mark', 'Lee', 'San Jose', '', 'admin', 'inactive');
INSERT INTO `users` VALUES (50, 'Lisa Williams', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Lisa', 'Williams', 'San Francisco', '', 'helper', 'active');
INSERT INTO `users` VALUES (49, 'James White', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'James', 'White', 'Austin', '', 'visitor', 'active');
INSERT INTO `users` VALUES (48, 'Maria Hernandez', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Maria', 'Hernandez', 'Dallas', '', 'admin', 'inactive');
INSERT INTO `users` VALUES (47, 'Robert Martin', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Robert', 'Martin', 'San Diego', '', 'helper', 'active');
INSERT INTO `users` VALUES (46, 'Linda Chavez', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Linda', 'Chavez', 'San Antonio', '', 'visitor', 'active');
INSERT INTO `users` VALUES (45, 'David Davis', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'David', 'Davis', 'Philadelphia', '', 'admin', 'inactive');
INSERT INTO `users` VALUES (44, 'Sarah Brown', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Sarah', 'Brown', 'Phoenix', '', 'helper', 'active');
INSERT INTO `users` VALUES (43, 'Michael Williams', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Michael', 'Williams', 'Houston', '', 'visitor', 'active');
INSERT INTO `users` VALUES (42, 'Emily Johnson', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Emily', 'Johnson', 'Chicago', '', 'admin', 'inactive');
INSERT INTO `users` VALUES (41, 'Jane Smith', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'Jane', 'Smith', 'Los Angeles', '', 'helper', 'active');
INSERT INTO `users` VALUES (40, 'John Doe', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', '', 'John', 'Doe', 'New York', '', 'visitor', 'active');
INSERT INTO `users` VALUES (10, 'john_doe', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'john.doe@example.com', 'John', 'Doe', 'New York', 'QQ20250227-222706.png', 'admin', 'active');
INSERT INTO `users` VALUES (9, 'jane_smith', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'jane.smith@example.com', 'Jane', 'Smith', 'Los Angeles', 'profile2.jpg', 'helper', 'active');
INSERT INTO `users` VALUES (8, 'alice_johnson', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'alice.johnson@example.com', 'Alice', 'Johnson', 'Chicago', 'profile3.jpg', 'visitor', 'inactive');
INSERT INTO `users` VALUES (7, 'bob_brown', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'bob.brown@example.com', 'Bob', 'Brown', 'Houston', 'profile4.jpg', 'admin', 'active');
INSERT INTO `users` VALUES (6, 'charlie_davis', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'charlie.davis@example.com', 'Charlie', 'Davis', 'Phoenix', 'profile5.jpg', 'helper', 'active');
INSERT INTO `users` VALUES (5, 'diana_evans', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'diana.evans@example.com', 'Diana', 'Evans', 'Philadelphia', 'profile6.jpg', 'visitor', 'inactive');
INSERT INTO `users` VALUES (4, 'eve_foster', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'eve.foster@example.com', 'Eve', 'Foster', 'San Antonio', 'profile7.jpg', 'admin', 'active');
INSERT INTO `users` VALUES (3, 'frank_garcia', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'frank.garcia@example.com', 'Frank', 'Garcia', 'San Diego', 'profile8.jpg', 'helper', 'active');
INSERT INTO `users` VALUES (2, 'grace_hall', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'grace.hall@example.com', 'Grace', 'Hall', 'Dallas', 'profile9.jpg', 'visitor', 'inactive');
INSERT INTO `users` VALUES (1, 'hank_ivanov', '$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou', 'hank.ivanov@example.com', 'Hank', 'Ivanov', 'San Jose', 'profile10.jpg', 'helper', 'active');

SET FOREIGN_KEY_CHECKS = 1;
