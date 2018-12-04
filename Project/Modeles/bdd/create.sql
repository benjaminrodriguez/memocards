-- MySQL Script generated by MySQL Workbench
-- Tue Dec  4 10:35:11 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema memocards
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `memocards` ;

-- -----------------------------------------------------
-- Schema memocards
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `memocards` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `memocards` ;

-- -----------------------------------------------------
-- Table `memocards`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(25) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `profile_picture` VARCHAR(255) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `birth_date` DATE NOT NULL,
  `sex` VARCHAR(1) NOT NULL,
  `region` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`categorie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`categorie` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`categorie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`deck`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`deck` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`deck` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `autor_id` INT NOT NULL,
  `status` VARCHAR(10) NOT NULL,
  `picture` VARCHAR(255) NOT NULL,
  `date_creation` DATE NOT NULL,
  `categorie_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_deck_categorie1_idx` (`categorie_id` ASC) ,
  CONSTRAINT `fk_deck_categorie1`
    FOREIGN KEY (`categorie_id`)
    REFERENCES `memocards`.`categorie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`recto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`recto` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`recto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `question_cards` VARCHAR(255) NOT NULL,
  `deck_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recto_deck1_idx` (`deck_id` ASC) ,
  CONSTRAINT `fk_recto_deck1`
    FOREIGN KEY (`deck_id`)
    REFERENCES `memocards`.`deck` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`verso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`verso` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`verso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `answer_cards` VARCHAR(255) NOT NULL,
  `statut_cards` VARCHAR(5) NOT NULL,
  `recto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_verso_recto1_idx` (`recto_id` ASC) ,
  CONSTRAINT `fk_verso_recto1`
    FOREIGN KEY (`recto_id`)
    REFERENCES `memocards`.`recto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`succes_rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`succes_rate` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`succes_rate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `level_cards` INT NOT NULL,
  `chain` INT NOT NULL,
  `played_cards` INT NULL,
  `verso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_succes_rate_verso_idx` (`verso_id` ASC) ,
  CONSTRAINT `fk_succes_rate_verso`
    FOREIGN KEY (`verso_id`)
    REFERENCES `memocards`.`verso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`passed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`passed` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`passed` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_passed` DATETIME NULL,
  `number_game` INT NULL,
  `score_user` INT NULL,
  `user_id` INT NOT NULL,
  `deck_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_passed_user1_idx` (`user_id` ASC) ,
  INDEX `fk_passed_deck1_idx` (`deck_id` ASC) ,
  CONSTRAINT `fk_passed_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `memocards`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_passed_deck1`
    FOREIGN KEY (`deck_id`)
    REFERENCES `memocards`.`deck` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`comments_deck`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`comments_deck` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`comments_deck` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` LONGTEXT NOT NULL,
  `autor_id` INT NOT NULL,
  `deck_id` INT NOT NULL,
  `mark` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_deck_deck1_idx` (`deck_id` ASC) ,
  CONSTRAINT `fk_comments_deck_deck1`
    FOREIGN KEY (`deck_id`)
    REFERENCES `memocards`.`deck` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`subject` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`subject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `date_posted` DATETIME NOT NULL,
  `content` LONGTEXT NOT NULL,
  `status` VARCHAR(15) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subject_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_subject_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `memocards`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`message` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `content_message` LONGTEXT NOT NULL,
  `autor_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_subject1_idx` (`subject_id` ASC) ,
  CONSTRAINT `fk_message_subject1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `memocards`.`subject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`hashtag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`hashtag` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`hashtag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`hashtag_has_deck`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`hashtag_has_deck` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`hashtag_has_deck` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `deck_id` INT NOT NULL,
  `hashtag_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hashtag_has_deck_deck1_idx` (`deck_id` ASC) ,
  INDEX `fk_hashtag_has_deck_hashtag1_idx` (`hashtag_id` ASC) ,
  CONSTRAINT `fk_hashtag_has_deck_deck1`
    FOREIGN KEY (`deck_id`)
    REFERENCES `memocards`.`deck` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hashtag_has_deck_hashtag1`
    FOREIGN KEY (`hashtag_id`)
    REFERENCES `memocards`.`hashtag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`hobbies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`hobbies` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`hobbies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hobby` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`hobbies_has_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`hobbies_has_user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`hobbies_has_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `hobbies_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hobbies_has_user_user1_idx` (`user_id` ASC) ,
  INDEX `fk_hobbies_has_user_hobbies1_idx` (`hobbies_id` ASC) ,
  CONSTRAINT `fk_hobbies_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `memocards`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hobbies_has_user_hobbies1`
    FOREIGN KEY (`hobbies_id`)
    REFERENCES `memocards`.`hobbies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `memocards`.`mp_forum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `memocards`.`mp_forum` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `memocards`.`mp_forum` (
  `mp_id` INT NOT NULL AUTO_INCREMENT,
  `mp_expediteur` INT NOT NULL,
  `mp_receveur` INT NOT NULL,
  `mp_titre` VARCHAR(255) NOT NULL,
  `mp_text` LONGTEXT NOT NULL,
  `mp_time` INT NOT NULL,
  `mp_lu` ENUM('0', '1') NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`mp_id`),
  INDEX `fk_mp_forum_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_mp_forum_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `memocards`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
