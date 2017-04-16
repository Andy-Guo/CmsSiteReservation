CREATE DATABASE `site_reservation` DEFAULT CHARACTER SET utf8;

CREATE TABLE `site_reservation`.`user` (
	`id` VARCHAR(20) NOT NULL,
	`name` varchar(255) NOT NULL,
	`password` varchar(128) NOT NULL,
	`description` varchar(128) DEFAULT '',
	`role_id` int NOT NULL,
	`count_rank` int DEFAULT 0,
	`paid` float DEFAULT 0,
	`phone_num` varchar(32) DEFAULT '',
	`email` varchar(32) DEFAULT '',
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,	
	PRIMARY KEY(`id`),
	UNIQUE KEY `u_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `site_reservation`.`role` (
	`id` VARCHAR(20) NOT NULL,
	`name` varchar(255) NOT NULL,
	`desc` text,
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `site_reservation`.`room` (
	`id` VARCHAR(20) NOT NULL,
	`name` varchar(255) NOT NULL,
	`desc` text,
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,	
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `site_reservation`.`time` (
	`id` VARCHAR(20) NOT NULL,
	`time_duration` int DEFAULT 1,
	`date` datetime NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `site_reservation`.`root_time_state` (
	`id` VARCHAR(20) NOT NULL,
	`room_id` VARCHAR(20) NOT NULL,
	`time_id` VARCHAR(20) NOT NULL,
	`user_id` VARCHAR(20) ,
	`is_order` int DEFAULT 1,
	`has_order` int DEFAULT 0,
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `site_reservation`.`price` (
	`id` VARCHAR(20) NOT NULL,
	`name` varchar(255) NOT NULL,
	`desc` text,
	`count_rank` int DEFAULT 0,
	`room_id` VARCHAR(20) NOT NULL,
	`time_id` VARCHAR(20) NOT NULL,
	`price` float DEFAULT 0,
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `site_reservation`.`appointment` (
	`id` VARCHAR(20) NOT NULL,
    `room_time_id` VARCHAR(20) NOT NULL,
	`price_id` VARCHAR(20) NOT NULL,
	`pay_fee` float DEFAULT 0,
	`rate` float DEFAULT 1,
	`status` int NOT NULL,
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
	
CREATE TABLE `site_reservation`.`work_order` (
	`id` VARCHAR(20) NOT NULL,
    `role_id` VARCHAR(20) NOT NULL,
	`appointment_id` VARCHAR(20) NOT NULL,
	`status` int NOT NULL,
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
		