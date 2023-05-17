/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50562
 Source Host           : localhost:3306
 Source Schema         : d6_wangshangkaoshi

 Target Server Type    : MySQL
 Target Server Version : 50562
 File Encoding         : 65001

 Date: 11/03/2020 14:30:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_clazz
-- ----------------------------
DROP TABLE IF EXISTS `t_clazz`;
CREATE TABLE `t_clazz`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_clazz
-- ----------------------------
INSERT INTO `t_clazz` VALUES (1, '电商2016');
INSERT INTO `t_clazz` VALUES (2, '计科2016');

-- ----------------------------
-- Table structure for t_course
-- ----------------------------
DROP TABLE IF EXISTS `t_course`;
CREATE TABLE `t_course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `teacherId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `FK62BB32463C711F0F`(`teacherId`) USING BTREE,
  CONSTRAINT `FK62BB32463C711F0F` FOREIGN KEY (`teacherId`) REFERENCES `t_teacher` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_course
-- ----------------------------
INSERT INTO `t_course` VALUES (1, '物流管理', 1);
INSERT INTO `t_course` VALUES (2, '操作系统', 1);

-- ----------------------------
-- Table structure for t_course_clazz
-- ----------------------------
DROP TABLE IF EXISTS `t_course_clazz`;
CREATE TABLE `t_course_clazz`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clazzId` int(11) NULL DEFAULT NULL,
  `courseId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `FK40C3F31F7176027B`(`clazzId`) USING BTREE,
  INDEX `FK40C3F31F7DDD31E1`(`courseId`) USING BTREE,
  CONSTRAINT `FK40C3F31F7176027B` FOREIGN KEY (`clazzId`) REFERENCES `t_clazz` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK40C3F31F7DDD31E1` FOREIGN KEY (`courseId`) REFERENCES `t_course` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_course_clazz
-- ----------------------------
INSERT INTO `t_course_clazz` VALUES (2, 2, 2);
INSERT INTO `t_course_clazz` VALUES (3, 1, 2);

-- ----------------------------
-- Table structure for t_paper
-- ----------------------------
DROP TABLE IF EXISTS `t_paper`;
CREATE TABLE `t_paper`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courseId` int(11) NULL DEFAULT NULL,
  `examTime` int(11) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `teacherId` int(11) NULL DEFAULT NULL,
  `youxiao` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `sid`(`sid`) USING BTREE,
  INDEX `FKA0C74E017DDD31E1`(`courseId`) USING BTREE,
  CONSTRAINT `FKA0C74E017DDD31E1` FOREIGN KEY (`courseId`) REFERENCES `t_course` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_paper
-- ----------------------------
INSERT INTO `t_paper` VALUES (1, 2, 60, '2019期末考', '00001', 1, '否');
INSERT INTO `t_paper` VALUES (2, 2, 60, '2020第一次测试', '00002', 1, '否');
INSERT INTO `t_paper` VALUES (3, 2, 40, 'Test1.0', '00003', 1, '是');

-- ----------------------------
-- Table structure for t_paper_question
-- ----------------------------
DROP TABLE IF EXISTS `t_paper_question`;
CREATE TABLE `t_paper_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paperId` int(11) NULL DEFAULT NULL,
  `questionId` int(11) NULL DEFAULT NULL,
  `questionScore` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `FK63C15064DA318EB7`(`questionId`) USING BTREE,
  INDEX `FK63C15064FDDD3E3`(`paperId`) USING BTREE,
  CONSTRAINT `FK63C15064DA318EB7` FOREIGN KEY (`questionId`) REFERENCES `t_question` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK63C15064FDDD3E3` FOREIGN KEY (`paperId`) REFERENCES `t_paper` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_paper_question
-- ----------------------------
INSERT INTO `t_paper_question` VALUES (1, 1, 5, 2);
INSERT INTO `t_paper_question` VALUES (2, 1, 7, 2);
INSERT INTO `t_paper_question` VALUES (3, 1, 25, 4);
INSERT INTO `t_paper_question` VALUES (4, 1, 27, 4);
INSERT INTO `t_paper_question` VALUES (5, 1, 38, 4);
INSERT INTO `t_paper_question` VALUES (6, 1, 33, 4);
INSERT INTO `t_paper_question` VALUES (7, 1, 57, 5);
INSERT INTO `t_paper_question` VALUES (8, 1, 55, 5);
INSERT INTO `t_paper_question` VALUES (9, 1, 42, 10);
INSERT INTO `t_paper_question` VALUES (10, 2, 4, 10);
INSERT INTO `t_paper_question` VALUES (11, 2, 17, 10);
INSERT INTO `t_paper_question` VALUES (12, 2, 35, 20);
INSERT INTO `t_paper_question` VALUES (13, 2, 55, 20);
INSERT INTO `t_paper_question` VALUES (14, 2, 46, 40);
INSERT INTO `t_paper_question` VALUES (15, 3, 3, 10);
INSERT INTO `t_paper_question` VALUES (16, 3, 29, 10);
INSERT INTO `t_paper_question` VALUES (17, 3, 31, 20);
INSERT INTO `t_paper_question` VALUES (18, 3, 53, 20);
INSERT INTO `t_paper_question` VALUES (19, 3, 48, 40);

-- ----------------------------
-- Table structure for t_question
-- ----------------------------
DROP TABLE IF EXISTS `t_question`;
CREATE TABLE `t_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `courseId` int(11) NULL DEFAULT NULL,
  `option1` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `option2` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `option3` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `option4` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `quesType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL,
  `teacherId` int(11) NULL DEFAULT NULL,
  `title` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `userType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zqlv` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `FK712EAF513C711F0F`(`teacherId`) USING BTREE,
  INDEX `FK712EAF517DDD31E1`(`courseId`) USING BTREE,
  CONSTRAINT `FK712EAF513C711F0F` FOREIGN KEY (`teacherId`) REFERENCES `t_teacher` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK712EAF517DDD31E1` FOREIGN KEY (`courseId`) REFERENCES `t_course` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_question
-- ----------------------------
INSERT INTO `t_question` VALUES (1, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (2, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (3, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (4, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (5, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (6, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (7, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (8, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (9, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (10, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (11, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (12, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (13, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (14, 'c', 2, '多道程序设计', '中断处理', '程序的并发执行', '实现分时与实时', '单选题', 2, 1, '现代操作系统的两个基本特征是( )和资源共享。', '简单', NULL);
INSERT INTO `t_question` VALUES (15, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (16, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (17, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (18, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (19, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (20, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (21, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (22, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (23, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (24, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (25, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (26, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (27, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (28, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (29, 'cd', 2, '立即关机排除故障', '立即关机再重新开机', '设计预防死锁方法', '运行检测并恢复', '多选题', 4, 1, '解决死锁的途径是（ ）', '中等', NULL);
INSERT INTO `t_question` VALUES (30, '0', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '线程支持的操作系统中调度和资源分配均以线程为单位 。', '中等', NULL);
INSERT INTO `t_question` VALUES (31, '1', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '实时操作系统中会出现某个进程的工作请求不能及时完成的情况。', '中等', NULL);
INSERT INTO `t_question` VALUES (32, '1', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '多级反馈队列调度算法是一种动态优先权优先算法。', '中等', NULL);
INSERT INTO `t_question` VALUES (33, '0', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '若系统中存在一个循环等待的进程集合，则必会死锁。', '中等', NULL);
INSERT INTO `t_question` VALUES (34, '1', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '记录型信号量比整型信号量更符合进程同步控制的让权等待原则。', '中等', NULL);
INSERT INTO `t_question` VALUES (35, '1', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '分页管理中采用反置页表管理方式时，每个进程有自己的一张外页表，但系统中只设一张反置页表即可。', '中等', NULL);
INSERT INTO `t_question` VALUES (36, '0', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '设备管理中为进程的I/O工作设置缓冲区以调节CPU与设备的速度差距，这些缓冲区往往是动态在硬盘上划分出来的。', '中等', NULL);
INSERT INTO `t_question` VALUES (37, '1', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '索引文件的索引表实际上就是一个定长记录的顺序文件。', '中等', NULL);
INSERT INTO `t_question` VALUES (38, '1', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, '目录结构中引入索引结点可提高文件检索速度。', '中等', NULL);
INSERT INTO `t_question` VALUES (39, '1', 2, NULL, NULL, NULL, NULL, '判断题', 4, 1, 'SPOOLing系统为了实现设备虚拟化设置的输入井、输出井在外存，而为了提高磁盘读写速度设计的“虚拟盘”实际是在内存中的。', '中等', NULL);
INSERT INTO `t_question` VALUES (40, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '三个进程P1、P2、P3互斥使用一个包含N（N>0）个单元的缓冲区。P1每次用produce（）生成一个正整数并用put（）送入缓冲区某一空单元中；P2每次用getodd（）从该缓冲区中取出一个奇数并用countodd（）统计奇数个数；P3每次用geteven（）从该缓冲区中取出一个偶数并用counteven（）统计偶数个数。请用信号量机制实现这三个进程的同步与互斥活动，并说明所定义的信号量的含义。要求用伪代码描述。', '困难', NULL);
INSERT INTO `t_question` VALUES (41, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '非抢占式调度方式中，什么情况下正在运行的进程会放弃CPU？', '困难', NULL);
INSERT INTO `t_question` VALUES (42, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '某系统有A、B、C、D四类资源可供五个进程P1.P2.P3.P4.P5共享。系统对这四类资源的拥有量为：A类3个、B类14个、C类12个、D类12个。进程对资源的需求和分配情况如下,请问现在是否是安全状态，请说明原因及判断过程。', '困难', NULL);
INSERT INTO `t_question` VALUES (43, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '某计算机主存按字节编址，使用一级页表的请求分页存储管理方式，逻辑地址和物理地址都是32位。若逻辑地址中后12位用于记录页内偏移量，页表项大小为4字节。问：\r\n    页的大小是多少字节？页表最大占用多少字节？\r\n    页表内容如下表（标记为0表示页未调入），设采用局部置换策略、最近最久未使用页面置换算法，页面历史使用序列为3、2、1、0、1，现要访问逻辑地址0000 2160H的数据，请写出其物理地址并说明计算的过程。', '困难', NULL);
INSERT INTO `t_question` VALUES (44, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '某文件占10个磁盘块，现要把该文件磁盘块逐个读入主存缓冲区，并送用户区进行分析。假设一个缓冲区与一个磁盘块大小相同，把一个磁盘块读入缓冲区的时间为100μs，将缓冲区的数据传送到用户区的时间是50μs，CPU对一块数据进行分析的时间为50μs。试计算在单缓冲区和双缓冲区结构下，读入并分析该文件的时间分别是多少，并画图说明计算过程。', '困难', NULL);
INSERT INTO `t_question` VALUES (45, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '某磁盘文件系统，采用混合索引分配方式，13个地址项记录在FCB中，第0-9个地址项为直接地址，第10个地址项为一次间接地址，第11个地址项为二次间接地址，第12个地址项为三次间接地址。如果每个盘块的大小为512字节，盘块号需要用3个字节来描述，问：\r\n1）该文件系统允许文件的最大长度是多少？\r\n2）若要读取字节地址为5000B处的文件数据，试计算得到其映射到的物理地址（磁盘块号及偏移量），请写明计算过程。\r\n', '困难', NULL);
INSERT INTO `t_question` VALUES (46, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '某磁盘文件系统，采用混合索引分配方式，13个地址项记录在FCB中，第0-9个地址项为直接地址，第10个地址项为一次间接地址，第11个地址项为二次间接地址，第12个地址项为三次间接地址。如果每个盘块的大小为512字节，盘块号需要用3个字节来描述，问：\r\n1）该文件系统允许文件的最大长度是多少？\r\n2）若要读取字节地址为5000B处的文件数据，试计算得到其映射到的物理地址（磁盘块号及偏移量），请写明计算过程。\r\n', '困难', NULL);
INSERT INTO `t_question` VALUES (47, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '某磁盘文件系统，采用混合索引分配方式，13个地址项记录在FCB中，第0-9个地址项为直接地址，第10个地址项为一次间接地址，第11个地址项为二次间接地址，第12个地址项为三次间接地址。如果每个盘块的大小为512字节，盘块号需要用3个字节来描述，问：\r\n1）该文件系统允许文件的最大长度是多少？\r\n2）若要读取字节地址为5000B处的文件数据，试计算得到其映射到的物理地址（磁盘块号及偏移量），请写明计算过程。\r\n', '困难', NULL);
INSERT INTO `t_question` VALUES (48, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '某磁盘文件系统，采用混合索引分配方式，13个地址项记录在FCB中，第0-9个地址项为直接地址，第10个地址项为一次间接地址，第11个地址项为二次间接地址，第12个地址项为三次间接地址。如果每个盘块的大小为512字节，盘块号需要用3个字节来描述，问：\r\n1）该文件系统允许文件的最大长度是多少？\r\n2）若要读取字节地址为5000B处的文件数据，试计算得到其映射到的物理地址（磁盘块号及偏移量），请写明计算过程。\r\n', '困难', NULL);
INSERT INTO `t_question` VALUES (49, '无', 2, NULL, NULL, NULL, NULL, '简答题', 10, 1, '某磁盘文件系统，采用混合索引分配方式，13个地址项记录在FCB中，第0-9个地址项为直接地址，第10个地址项为一次间接地址，第11个地址项为二次间接地址，第12个地址项为三次间接地址。如果每个盘块的大小为512字节，盘块号需要用3个字节来描述，问：\r\n1）该文件系统允许文件的最大长度是多少？\r\n2）若要读取字节地址为5000B处的文件数据，试计算得到其映射到的物理地址（磁盘块号及偏移量），请写明计算过程。\r\n', '困难', NULL);
INSERT INTO `t_question` VALUES (50, '临界区', 2, NULL, NULL, NULL, NULL, '填空题', 5, 1, '一段时间内只允许一个进程访问的资源，称为临界资源,程序代码中访问这类资源的代码称为__________________  。\r\n', '中等', NULL);
INSERT INTO `t_question` VALUES (51, '进程控制块', 2, NULL, NULL, NULL, NULL, '填空题', 5, 1, ' ________________ 是进程存在的唯一标志？\r\n', '中等', NULL);
INSERT INTO `t_question` VALUES (52, 'DMA控制方式', 2, NULL, NULL, NULL, NULL, '填空题', 5, 1, '可以由控制器直接进行内存存取，一次处理一个连续块的数据的I/O控制方式是：______________________。', '中等', NULL);
INSERT INTO `t_question` VALUES (53, '缓冲池', 2, NULL, NULL, NULL, NULL, '填空题', 5, 1, '设备管理中管理多个缓冲区可以采用“循环缓冲”和“_____________”两种不同的方式。', '中等', NULL);
INSERT INTO `t_question` VALUES (54, '符号链', 2, NULL, NULL, NULL, NULL, '填空题', 5, 1, '文件共享主要有两种方式，一是基于索引节点的共享方式，称为硬链接，二是利用_________________实现文件共享，称为软链接。', '中等', NULL);
INSERT INTO `t_question` VALUES (55, '符号链', 2, NULL, NULL, NULL, NULL, '填空题', 5, 1, '文件共享主要有两种方式，一是基于索引节点的共享方式，称为硬链接，二是利用_________________实现文件共享，称为软链接。', '中等', NULL);
INSERT INTO `t_question` VALUES (56, '符号链', 2, NULL, NULL, NULL, NULL, '填空题', 5, 1, '文件共享主要有两种方式，一是基于索引节点的共享方式，称为硬链接，二是利用_________________实现文件共享，称为软链接。', '中等', NULL);
INSERT INTO `t_question` VALUES (57, '符号链', 2, '', '', '', '', '填空题', 5, 1, '文件共享主要有两种方式，一是基于索引节点的共享方式，称为硬链接，二是利用_________________实现文件共享，称为软链接。', '中等', NULL);
INSERT INTO `t_question` VALUES (64, 'a', 2, 'a1', 'a2', 'a3', 'a4', '单选题', 2, 1, '单选题题目1', '简单', 0);
INSERT INTO `t_question` VALUES (65, 'bcd', 2, 'b1', 'b2', 'b3', 'b4', '多选题', 4, 1, '多选题题目1', '中等', 0);
INSERT INTO `t_question` VALUES (66, '1', 2, '', '', '', '', '判断题', 4, 1, '判断题1', '困难', 0);
INSERT INTO `t_question` VALUES (67, '0', 2, '', '', '', '', '判断题', 4, 1, '判断题2', '困难', 0);
INSERT INTO `t_question` VALUES (68, '什么', 2, '', '', '', '', '填空题', 5, 1, '什么是_____填空题1', '困难', 0);
INSERT INTO `t_question` VALUES (69, '', 2, '', '', '', '', '简答题', 10, 1, '简答题简答题简答题简答题', '困难', 0);

-- ----------------------------
-- Table structure for t_sensitive
-- ----------------------------
DROP TABLE IF EXISTS `t_sensitive`;
CREATE TABLE `t_sensitive`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `word`(`word`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for t_student
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clazzId` int(11) NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userAddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userBirth` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userEmail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userGender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPassword` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPhone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uname`(`uname`) USING BTREE,
  INDEX `FK4B9075707176027B`(`clazzId`) USING BTREE,
  CONSTRAINT `FK4B9075707176027B` FOREIGN KEY (`clazzId`) REFERENCES `t_clazz` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES (1, 2, NULL, '201601', '', '', '', '女', '王琦', 'E10ADC3949BA59ABBE56E057F20F883E', '');
INSERT INTO `t_student` VALUES (2, 2, NULL, '201602', '', '', '', '女', '四强', 'E10ADC3949BA59ABBE56E057F20F883E', '');
INSERT INTO `t_student` VALUES (3, 1, NULL, '201603', '', '', '', '男', '王宝强', 'E10ADC3949BA59ABBE56E057F20F883E', '');

-- ----------------------------
-- Table structure for t_student_exam
-- ----------------------------
DROP TABLE IF EXISTS `t_student_exam`;
CREATE TABLE `t_student_exam`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `checkTeacherId` int(11) NULL DEFAULT NULL,
  `courseId` int(11) NULL DEFAULT NULL,
  `finished` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keguan` int(11) NULL DEFAULT NULL,
  `paperId` int(11) NULL DEFAULT NULL,
  `studentId` int(11) NULL DEFAULT NULL,
  `zhuguan` int(11) NULL DEFAULT NULL,
  `zong` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `FKD9F9E18E30722C83`(`studentId`) USING BTREE,
  INDEX `FKD9F9E18E32AA6307`(`checkTeacherId`) USING BTREE,
  INDEX `FKD9F9E18EFDDD3E3`(`paperId`) USING BTREE,
  CONSTRAINT `FKD9F9E18E30722C83` FOREIGN KEY (`studentId`) REFERENCES `t_student` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FKD9F9E18E32AA6307` FOREIGN KEY (`checkTeacherId`) REFERENCES `t_teacher` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FKD9F9E18EFDDD3E3` FOREIGN KEY (`paperId`) REFERENCES `t_paper` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_student_exam
-- ----------------------------
INSERT INTO `t_student_exam` VALUES (5, '2020-03-05', 1, 2, '已阅卷', 20, 2, 1, 35, 55);
INSERT INTO `t_student_exam` VALUES (6, '2020-03-06', 1, 2, '已阅卷', 30, 3, 1, 36, 66);

-- ----------------------------
-- Table structure for t_student_exam_question
-- ----------------------------
DROP TABLE IF EXISTS `t_student_exam_question`;
CREATE TABLE `t_student_exam_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `correct` bit(1) NULL DEFAULT NULL,
  `examId` int(11) NULL DEFAULT NULL,
  `jiandascore` int(11) NULL DEFAULT NULL,
  `questionId` int(11) NULL DEFAULT NULL,
  `questionScore` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `FK1B376B77DA318EB7`(`questionId`) USING BTREE,
  INDEX `FK1B376B77AFEC6524`(`examId`) USING BTREE,
  CONSTRAINT `FK1B376B77AFEC6524` FOREIGN KEY (`examId`) REFERENCES `t_student_exam` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK1B376B77DA318EB7` FOREIGN KEY (`questionId`) REFERENCES `t_question` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_student_exam_question
-- ----------------------------
INSERT INTO `t_student_exam_question` VALUES (37, 'A', b'0', 5, NULL, 4, 10);
INSERT INTO `t_student_exam_question` VALUES (38, 'AB', b'0', 5, NULL, 17, 10);
INSERT INTO `t_student_exam_question` VALUES (39, '1', b'1', 5, NULL, 35, 20);
INSERT INTO `t_student_exam_question` VALUES (40, '11', b'0', 5, NULL, 55, 20);
INSERT INTO `t_student_exam_question` VALUES (41, '22222222222222222222222222', b'0', 5, 35, 46, 40);
INSERT INTO `t_student_exam_question` VALUES (42, 'A', b'0', 6, NULL, 3, 10);
INSERT INTO `t_student_exam_question` VALUES (43, 'CD', b'1', 6, NULL, 29, 10);
INSERT INTO `t_student_exam_question` VALUES (44, '1', b'1', 6, NULL, 31, 20);
INSERT INTO `t_student_exam_question` VALUES (45, '11', b'0', 6, NULL, 53, 20);
INSERT INTO `t_student_exam_question` VALUES (46, '111111111111111111', b'0', 6, 36, 48, 40);

-- ----------------------------
-- Table structure for t_sysuser
-- ----------------------------
DROP TABLE IF EXISTS `t_sysuser`;
CREATE TABLE `t_sysuser`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userAddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userBirth` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userEmail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userGender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPassword` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPhone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uname`(`uname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_sysuser
-- ----------------------------
INSERT INTO `t_sysuser` VALUES (1, 'admin', NULL, NULL, NULL, '男', '管理员', 'E10ADC3949BA59ABBE56E057F20F883E', NULL);

-- ----------------------------
-- Table structure for t_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userAddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userBirth` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userEmail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userGender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPassword` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPhone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uname`(`uname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_teacher
-- ----------------------------
INSERT INTO `t_teacher` VALUES (1, '1001', '', '', '', '女', '王教授', 'E10ADC3949BA59ABBE56E057F20F883E', '', '1576603159270.jpg');
INSERT INTO `t_teacher` VALUES (2, '1002', '', '', '', '女', '宋老师', 'E10ADC3949BA59ABBE56E057F20F883E', '', '1576603148143.png');

-- ----------------------------
-- Table structure for t_user_question
-- ----------------------------
DROP TABLE IF EXISTS `t_user_question`;
CREATE TABLE `t_user_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionId` int(11) NULL DEFAULT NULL,
  `userId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `FK463F8D4FDA318EB7`(`questionId`) USING BTREE,
  INDEX `FK463F8D4F74367213`(`userId`) USING BTREE,
  CONSTRAINT `FK463F8D4F74367213` FOREIGN KEY (`userId`) REFERENCES `t_student` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK463F8D4FDA318EB7` FOREIGN KEY (`questionId`) REFERENCES `t_question` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_user_question
-- ----------------------------
INSERT INTO `t_user_question` VALUES (2, 1, 1);
INSERT INTO `t_user_question` VALUES (3, 2, 1);
INSERT INTO `t_user_question` VALUES (5, 17, 1);
INSERT INTO `t_user_question` VALUES (9, 10, 1);
INSERT INTO `t_user_question` VALUES (10, 18, 1);

SET FOREIGN_KEY_CHECKS = 1;
