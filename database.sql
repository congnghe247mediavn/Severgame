-- TAI XIU / CHAN LE / BAU CUA - schema starter
-- Reconstructed from the supplied PHP source because the original ZIP did not contain a .sql dump.
-- IMPORTANT: This is a starter schema, not a verified original database backup.
-- Import into a NEW empty database first. Back up any existing database before changing it.
SET NAMES utf8mb4;
SET time_zone = '+07:00';

CREATE TABLE IF NOT EXISTS `nguoichoi` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `taikhoan` VARCHAR(100) NOT NULL,
  `email` VARCHAR(190) DEFAULT NULL,
  `xu` BIGINT NOT NULL DEFAULT 0,
  `tien` BIGINT NOT NULL DEFAULT 0,
  `win` BIGINT NOT NULL DEFAULT 0,
  `admin` INT NOT NULL DEFAULT 0,
  `thongtin` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_nguoichoi_taikhoan` (`taikhoan`),
  KEY `idx_nguoichoi_xu` (`xu`),
  KEY `idx_nguoichoi_admin` (`admin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip` VARCHAR(64) DEFAULT NULL,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `url` VARCHAR(512) DEFAULT NULL,
  `get1` LONGTEXT NULL,
  `post` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_log_ip_uid` (`ip`,`uid`),
  KEY `idx_log_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `doanhthu` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ngay` INT NOT NULL DEFAULT 0,
  `thang` INT NOT NULL DEFAULT 0,
  `nam` INT NOT NULL DEFAULT 0,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_doanhthu_ngay` (`ngay`,`thang`,`nam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phien_ngocrong` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phien_chanle` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phien_baucua` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `cuoc_ngocrong` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `az` VARCHAR(128) DEFAULT NULL,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cuoc_ngocrong_uid` (`uid`),
  KEY `idx_cuoc_ngocrong_az` (`az`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `cuoc_chanle` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `az` VARCHAR(128) DEFAULT NULL,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cuoc_chanle_uid` (`uid`),
  KEY `idx_cuoc_chanle_az` (`az`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `cuoc_baucua` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `az` VARCHAR(128) DEFAULT NULL,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cuoc_baucua_uid` (`uid`),
  KEY `idx_cuoc_baucua_az` (`az`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sodu` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `truoc` BIGINT NOT NULL DEFAULT 0,
  `sau` BIGINT NOT NULL DEFAULT 0,
  `time` BIGINT NOT NULL DEFAULT 0,
  `xu` BIGINT NOT NULL DEFAULT 0,
  `noidung` VARCHAR(255) DEFAULT NULL,
  `thoigian` VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sodu_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `login` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_login_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `chat` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `thoigian` VARCHAR(32) DEFAULT NULL,
  `noidung` TEXT NULL,
  `uid` BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_chat_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sms` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `from` BIGINT NOT NULL DEFAULT 0,
  `to` BIGINT NOT NULL DEFAULT 0,
  `time` BIGINT NOT NULL DEFAULT 0,
  `text` TEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sms_from_to` (`from`,`to`),
  KEY `idx_sms_to_from` (`to`,`from`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sms_list` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `from` BIGINT NOT NULL DEFAULT 0,
  `to` BIGINT NOT NULL DEFAULT 0,
  `time` BIGINT NOT NULL DEFAULT 0,
  `new` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_sms_list_from_to` (`from`,`to`),
  KEY `idx_sms_list_to_from` (`to`,`from`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `giftcode` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(128) DEFAULT NULL,
  `xu` BIGINT NOT NULL DEFAULT 0,
  `data` LONGTEXT NULL,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `soluong` BIGINT NOT NULL DEFAULT 0,
  `used` BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_giftcode_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `log_giftcode` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `text` VARCHAR(255) DEFAULT NULL,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_log_giftcode_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `log_nap` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_log_nap_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `logrut` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `thoigian` VARCHAR(64) DEFAULT NULL,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `code` VARCHAR(128) DEFAULT NULL,
  `thongtin` LONGTEXT NULL,
  `vnd` BIGINT NOT NULL DEFAULT 0,
  `thucnhan` BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_logrut_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `napthe` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `data` LONGTEXT NULL,
  `status` VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_napthe_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `bank` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `data` LONGTEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_bank_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `chuyentien` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` BIGINT NOT NULL DEFAULT 0,
  `data` LONGTEXT NULL,
  `time` BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_chuyentien_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
