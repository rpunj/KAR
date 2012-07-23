SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `kar` DEFAULT CHARACTER SET latin1 ;
USE `kar` ;

-- -----------------------------------------------------
-- Table `kar`.`affiliate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`affiliate` ;

CREATE  TABLE IF NOT EXISTS `kar`.`affiliate` (
  `affiliate_id` INT NOT NULL AUTO_INCREMENT ,
  `affiliate_name` VARCHAR(45) NOT NULL ,
  `affiliate_domain` VARCHAR(45) NOT NULL ,
  `affiliate_phone_number` VARCHAR(45) NULL ,
  `affiliate_address` INT NOT NULL ,
  `affiliate_signups` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`affiliate_id`) ,
  INDEX `fk_affiliate_address1` (`affiliate_address` ASC) ,
  CONSTRAINT `fk_affiliate_address1`
    FOREIGN KEY (`affiliate_address` )
    REFERENCES `kar`.`address` (`address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`search_domains`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`search_domains` ;

CREATE  TABLE IF NOT EXISTS `kar`.`search_domains` (
  `search_domain_id` INT NOT NULL ,
  `search_domain_name` VARCHAR(45) NOT NULL ,
  `search_domain_description` TEXT NOT NULL ,
  PRIMARY KEY (`search_domain_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`search`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`search` ;

CREATE  TABLE IF NOT EXISTS `kar`.`search` (
  `search_id` INT NOT NULL ,
  `search_owner` INT NOT NULL ,
  `search_start_subzone` INT NOT NULL ,
  `search_end_subzone` INT NOT NULL ,
  `search_preferences` INT NOT NULL ,
  `search_domain` INT NOT NULL ,
  PRIMARY KEY (`search_id`, `search_owner`) ,
  INDEX `fk_search_user1` (`search_owner` ASC) ,
  INDEX `fk_search_search_domains1` (`search_domain` ASC) ,
  CONSTRAINT `fk_search_user1`
    FOREIGN KEY (`search_owner` )
    REFERENCES `kar`.`user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_search_search_domains1`
    FOREIGN KEY (`search_domain` )
    REFERENCES `kar`.`search_domains` (`search_domain_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`carpool`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`carpool` ;

CREATE  TABLE IF NOT EXISTS `kar`.`carpool` (
  `carpool_id` INT NOT NULL ,
  `carpool_start_subzone` INT NOT NULL ,
  `carpool_end_subzone` INT NOT NULL ,
  `carpool_member_count` INT NOT NULL ,
  `carpool_morning_time` INT NOT NULL ,
  `carpool_evening_time` INT NOT NULL ,
  `carpool_driver` INT NULL ,
  PRIMARY KEY (`carpool_id`) ,
  INDEX `fk_carpool_carpool_item1` (`carpool_driver` ASC) ,
  CONSTRAINT `fk_carpool_carpool_item1`
    FOREIGN KEY (`carpool_driver` )
    REFERENCES `kar`.`carpool_item` (`carpool_item_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`carpool_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`carpool_item` ;

CREATE  TABLE IF NOT EXISTS `kar`.`carpool_item` (
  `carpool_item_id` INT NOT NULL ,
  `carpool_id` INT NOT NULL ,
  `carpool_user` INT NOT NULL ,
  PRIMARY KEY (`carpool_item_id`, `carpool_id`) ,
  INDEX `fk_carpool_item_carpool1` (`carpool_id` ASC) ,
  INDEX `fk_carpool_item_user1` (`carpool_user` ASC) ,
  CONSTRAINT `fk_carpool_item_carpool1`
    FOREIGN KEY (`carpool_id` )
    REFERENCES `kar`.`carpool` (`carpool_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carpool_item_user1`
    FOREIGN KEY (`carpool_user` )
    REFERENCES `kar`.`user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`user` ;

CREATE  TABLE IF NOT EXISTS `kar`.`user` (
  `user_id` INT NOT NULL ,
  `user_name` VARCHAR(45) NOT NULL ,
  `user_email` VARCHAR(45) NOT NULL ,
  `user_pwd_hash` VARCHAR(45) NOT NULL ,
  `user_username` VARCHAR(45) NOT NULL ,
  `user_home_address` INT NOT NULL ,
  `user_dest_address` INT NULL ,
  `user_phone` VARCHAR(45) NOT NULL ,
  `user_phone_2` VARCHAR(45) NULL ,
  `user_id_url` VARCHAR(45) NULL ,
  `user_id_url_2` VARCHAR(45) NULL ,
  `user_carpool_id` INT NULL ,
  `user_default_preferences` INT NOT NULL ,
  `user_affliate` INT NULL ,
  `user_search_count` INT NOT NULL ,
  `user_default_search` INT NULL ,
  PRIMARY KEY (`user_id`) ,
  INDEX `fk_user_address1` (`user_home_address` ASC) ,
  INDEX `fk_user_address2` (`user_dest_address` ASC) ,
  INDEX `fk_user_affiliate1` (`user_affliate` ASC) ,
  INDEX `fk_user_search1` (`user_default_search` ASC) ,
  INDEX `fk_user_carpool_item1` (`user_carpool_id` ASC) ,
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`user_home_address` )
    REFERENCES `kar`.`address` (`address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_address2`
    FOREIGN KEY (`user_dest_address` )
    REFERENCES `kar`.`address` (`address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_affiliate1`
    FOREIGN KEY (`user_affliate` )
    REFERENCES `kar`.`affiliate` (`affiliate_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_search1`
    FOREIGN KEY (`user_default_search` )
    REFERENCES `kar`.`search` (`search_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_carpool_item1`
    FOREIGN KEY (`user_carpool_id` )
    REFERENCES `kar`.`carpool_item` (`carpool_item_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`zone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`zone` ;

CREATE  TABLE IF NOT EXISTS `kar`.`zone` (
  `zone_id` INT NOT NULL ,
  `zone_name` VARCHAR(45) NOT NULL ,
  `zone_children` VARCHAR(100) NULL ,
  `zone_parents` VARCHAR(100) NULL ,
  `zone_lon` DOUBLE NOT NULL ,
  `zone_lat` DOUBLE NOT NULL ,
  `zone_population` INT ZEROFILL NOT NULL ,
  `zone_city_id` INT NULL ,
  PRIMARY KEY (`zone_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`address` ;

CREATE  TABLE IF NOT EXISTS `kar`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT ,
  `address_owner` INT NOT NULL ,
  `address_city` INT NOT NULL ,
  `address_subzone` INT NOT NULL ,
  `address_details` VARCHAR(45) NULL ,
  `address_house_or_office` VARCHAR(45) NULL ,
  PRIMARY KEY (`address_id`, `address_owner`) ,
  INDEX `fk_address_user1` (`address_owner` ASC) ,
  INDEX `fk_address_zone1` (`address_subzone` ASC) ,
  INDEX `fk_address_zone2` (`address_city` ASC) ,
  CONSTRAINT `fk_address_user1`
    FOREIGN KEY (`address_owner` )
    REFERENCES `kar`.`user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_zone1`
    FOREIGN KEY (`address_subzone` )
    REFERENCES `kar`.`zone` (`zone_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_zone2`
    FOREIGN KEY (`address_city` )
    REFERENCES `kar`.`zone` (`zone_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`contact_request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`contact_request` ;

CREATE  TABLE IF NOT EXISTS `kar`.`contact_request` (
  `request_id` INT NOT NULL ,
  `request_owner` INT NOT NULL ,
  `request_target` INT NOT NULL ,
  `request_status` INT NOT NULL ,
  `request_start_date_time` DATETIME NOT NULL ,
  `request_timeout` INT NOT NULL ,
  PRIMARY KEY (`request_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`list_domains`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`list_domains` ;

CREATE  TABLE IF NOT EXISTS `kar`.`list_domains` (
  `list_domain_id` INT NOT NULL ,
  `list_domain_name` VARCHAR(45) NOT NULL ,
  `list_domain_description` TEXT NULL ,
  PRIMARY KEY (`list_domain_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kar`.`list_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kar`.`list_item` ;

CREATE  TABLE IF NOT EXISTS `kar`.`list_item` (
  `list_id` INT NOT NULL ,
  `list_owner` INT NOT NULL ,
  `list_domain` INT NULL ,
  `list_member` INT NULL ,
  `list_contact_request_opt` INT NULL ,
  PRIMARY KEY (`list_id`, `list_owner`) ,
  INDEX `fk_list_item_list_domains` (`list_domain` ASC) ,
  INDEX `fk_list_item_user1` (`list_owner` ASC) ,
  INDEX `fk_list_item_contact_request1` (`list_contact_request_opt` ASC) ,
  UNIQUE INDEX `list_contact_request_opt_UNIQUE` (`list_contact_request_opt` ASC) ,
  CONSTRAINT `fk_list_item_list_domains`
    FOREIGN KEY (`list_domain` )
    REFERENCES `kar`.`list_domains` (`list_domain_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_list_item_user1`
    FOREIGN KEY (`list_owner` )
    REFERENCES `kar`.`user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_list_item_contact_request1`
    FOREIGN KEY (`list_contact_request_opt` )
    REFERENCES `kar`.`contact_request` (`request_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
