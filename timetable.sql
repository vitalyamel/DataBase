-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema timetableDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema timetableDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `timetableDB` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema timetabledb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema timetabledb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `timetabledb` DEFAULT CHARACTER SET utf8 ;
USE `timetableDB` ;

-- -----------------------------------------------------
-- Table `timetableDB`.`classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`classroom` (
  `idclassroom` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idclassroom`),
  UNIQUE INDEX `idclassroom_UNIQUE` (`idclassroom` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `timetableDB`.`professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`professors` (
  `idprofessors` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idprofessors`),
  UNIQUE INDEX `idprofessors_UNIQUE` (`idprofessors` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `timetableDB`.`study_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`study_groups` (
  `idstudy_groups` INT NOT NULL AUTO_INCREMENT,
  `name_group` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idstudy_groups`),
  UNIQUE INDEX `idstudy_groups_UNIQUE` (`idstudy_groups` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `timetableDB`.`discipline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`discipline` (
  `iddiscipline` INT NOT NULL AUTO_INCREMENT,
  `namediscipline` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`iddiscipline`),
  UNIQUE INDEX `idlesson_UNIQUE` (`iddiscipline` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `timetableDB`.`week_day`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`week_day` (
  `iddayweek` INT NOT NULL AUTO_INCREMENT,
  `weekday` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`iddayweek`),
  UNIQUE INDEX `iddayweek_UNIQUE` (`iddayweek` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `timetableDB`.`week_parity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`week_parity` (
  `idweek_chet` INT NOT NULL AUTO_INCREMENT,
  `week_chet` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idweek_chet`),
  UNIQUE INDEX `idweek_chet_UNIQUE` (`idweek_chet` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `timetableDB`.`lesson_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`lesson_type` (
  `idtype_lesson` INT NOT NULL AUTO_INCREMENT,
  `lesson_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtype_lesson`),
  UNIQUE INDEX `idtype_lesson_UNIQUE` (`idtype_lesson` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `timetableDB`.`timetable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`timetable` (
  `idschedule` INT NOT NULL,
  `week_chet_idweek_chet` INT NOT NULL,
  `day_week_iddayweek` INT NOT NULL,
  `classroom_idclassroom` INT NOT NULL,
  `study_groups_idstudy_groups` INT NOT NULL,
  `professors_idprofessors` INT NOT NULL,
  `lesson_idlesson` INT NOT NULL,
  `lesson_type_idtype_lesson` INT NOT NULL,
  PRIMARY KEY (`idschedule`),
  INDEX `fk_schedule_week_chet1_idx` (`week_chet_idweek_chet` ASC) VISIBLE,
  INDEX `fk_schedule_day_week1_idx` (`day_week_iddayweek` ASC) VISIBLE,
  INDEX `fk_schedule_classroom1_idx` (`classroom_idclassroom` ASC) VISIBLE,
  INDEX `fk_schedule_study_groups1_idx` (`study_groups_idstudy_groups` ASC) VISIBLE,
  INDEX `fk_schedule_professors1_idx` (`professors_idprofessors` ASC) VISIBLE,
  INDEX `fk_timetable_lesson1_idx` (`lesson_idlesson` ASC) VISIBLE,
  INDEX `fk_timetable_lesson_type1_idx` (`lesson_type_idtype_lesson` ASC) VISIBLE,
  CONSTRAINT `fk_schedule_week_chet1`
    FOREIGN KEY (`week_chet_idweek_chet`)
    REFERENCES `timetableDB`.`week_parity` (`idweek_chet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_day_week1`
    FOREIGN KEY (`day_week_iddayweek`)
    REFERENCES `timetableDB`.`week_day` (`iddayweek`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_classroom1`
    FOREIGN KEY (`classroom_idclassroom`)
    REFERENCES `timetableDB`.`classroom` (`idclassroom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_study_groups1`
    FOREIGN KEY (`study_groups_idstudy_groups`)
    REFERENCES `timetableDB`.`study_groups` (`idstudy_groups`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_professors1`
    FOREIGN KEY (`professors_idprofessors`)
    REFERENCES `timetableDB`.`professors` (`idprofessors`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_timetable_lesson1`
    FOREIGN KEY (`lesson_idlesson`)
    REFERENCES `timetableDB`.`discipline` (`iddiscipline`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_timetable_lesson_type1`
    FOREIGN KEY (`lesson_type_idtype_lesson`)
    REFERENCES `timetableDB`.`lesson_type` (`idtype_lesson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `timetableDB`.`lesson_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetableDB`.`lesson_time` (
  `idlesson_time` INT NOT NULL AUTO_INCREMENT,
  `lesson_number` INT NOT NULL,
  PRIMARY KEY (`idlesson_time`),
  UNIQUE INDEX `idlesson_time_UNIQUE` (`idlesson_time` ASC) VISIBLE,
  CONSTRAINT `lesson_time`
    FOREIGN KEY (`idlesson_time`)
    REFERENCES `timetableDB`.`timetable` (`study_groups_idstudy_groups`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `timetabledb` ;

-- -----------------------------------------------------
-- Table `timetabledb`.`classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`classroom` (
  `idclassroom` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idclassroom`),
  UNIQUE INDEX `idclassroom_UNIQUE` (`idclassroom` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `timetabledb`.`discipline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`discipline` (
  `iddiscipline` INT NOT NULL AUTO_INCREMENT,
  `namediscipline` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`iddiscipline`),
  UNIQUE INDEX `idlesson_UNIQUE` (`iddiscipline` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `timetabledb`.`lesson_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`lesson_time` (
  `idlesson_time` INT NOT NULL AUTO_INCREMENT,
  `lesson_number` INT NOT NULL,
  PRIMARY KEY (`idlesson_time`),
  UNIQUE INDEX `idlesson_time_UNIQUE` (`idlesson_time` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `timetabledb`.`lesson_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`lesson_type` (
  `idtype_lesson` INT NOT NULL AUTO_INCREMENT,
  `lesson_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtype_lesson`),
  UNIQUE INDEX `idtype_lesson_UNIQUE` (`idtype_lesson` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `timetabledb`.`professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`professors` (
  `idprofessors` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idprofessors`),
  UNIQUE INDEX `idprofessors_UNIQUE` (`idprofessors` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `timetabledb`.`study_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`study_groups` (
  `idstudy_groups` INT NOT NULL AUTO_INCREMENT,
  `name_group` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idstudy_groups`),
  UNIQUE INDEX `idstudy_groups_UNIQUE` (`idstudy_groups` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `timetabledb`.`week_day`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`week_day` (
  `iddayweek` INT NOT NULL AUTO_INCREMENT,
  `weekday` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`iddayweek`),
  UNIQUE INDEX `iddayweek_UNIQUE` (`iddayweek` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `timetabledb`.`week_parity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`week_parity` (
  `idweek_parity` INT NOT NULL AUTO_INCREMENT,
  `week_parity` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idweek_parity`),
  UNIQUE INDEX `idweek_chet_UNIQUE` (`idweek_parity` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `timetabledb`.`timetable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timetabledb`.`timetable` (
  `idschedule` INT NOT NULL AUTO_INCREMENT,
  `idlesson_time` INT NOT NULL,
  `idweek_parity` INT NOT NULL,
  `idweekday` INT NOT NULL,
  `idclassroom` INT NOT NULL,
  `idstudy_groups` INT NOT NULL,
  `idprofessors` INT NOT NULL,
  `idlesson` INT NOT NULL,
  `idlesson_type` INT NOT NULL,
  PRIMARY KEY (`idschedule`),
  UNIQUE INDEX `idschedule_UNIQUE` (`idschedule` ASC) VISIBLE,
  INDEX `fk_schedule_time_lesson_idx` (`idlesson_time` ASC) VISIBLE,
  INDEX `fk_schedule_week_chet1_idx` (`idweek_parity` ASC) VISIBLE,
  INDEX `fk_schedule_day_week1_idx` (`idweekday` ASC) VISIBLE,
  INDEX `fk_schedule_classroom1_idx` (`idclassroom` ASC) VISIBLE,
  INDEX `fk_schedule_study_groups1_idx` (`idstudy_groups` ASC) VISIBLE,
  INDEX `fk_schedule_professors1_idx` (`idprofessors` ASC) VISIBLE,
  INDEX `fk_timetable_lesson1_idx` (`idlesson` ASC) VISIBLE,
  INDEX `fk_timetable_lesson_type1_idx` (`idlesson_type` ASC) VISIBLE,
  CONSTRAINT `fk_schedule_classroom`
    FOREIGN KEY (`idclassroom`)
    REFERENCES `timetabledb`.`classroom` (`idclassroom`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_schedule_lesson_tme`
    FOREIGN KEY (`idlesson_time`)
    REFERENCES `timetabledb`.`lesson_time` (`idlesson_time`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_schedule_professors`
    FOREIGN KEY (`idprofessors`)
    REFERENCES `timetabledb`.`professors` (`idprofessors`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_schedule_study_groups`
    FOREIGN KEY (`idstudy_groups`)
    REFERENCES `timetabledb`.`study_groups` (`idstudy_groups`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_schedule_week_day`
    FOREIGN KEY (`idweekday`)
    REFERENCES `timetabledb`.`week_day` (`iddayweek`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_schedule_week_parity`
    FOREIGN KEY (`idweek_parity`)
    REFERENCES `timetabledb`.`week_parity` (`idweek_parity`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_timetable_lesson1`
    FOREIGN KEY (`idlesson`)
    REFERENCES `timetabledb`.`discipline` (`iddiscipline`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_timetable_lesson_type`
    FOREIGN KEY (`idlesson_type`)
    REFERENCES `timetabledb`.`lesson_type` (`idtype_lesson`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
