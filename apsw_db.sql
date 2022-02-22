CREATE DATABASE apsw_db;
USE apsw_db;

CREATE TABLE IF NOT EXISTS ASP_Credentials (
	asp_name VARCHAR(40) PRIMARY KEY,
	password_hash CHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS Vac_User (
    fiscal_code VARCHAR(16) PRIMARY KEY,
    given_name VARCHAR(80) NOT NULL,
    surname VARCHAR(80) NOT NULL,
    city VARCHAR(60) NOT NULL,
    birthdate DATE NOT NULL,
    gender INT NOT NULL, -- 1: male, 2: female, 3: other
    email VARCHAR(60) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Doctor (
    fiscal_code VARCHAR(16) PRIMARY KEY,
    given_name VARCHAR(80) NOT NULL,
    surname VARCHAR(80) NOT NULL,
    birthdate DATE NOT NULL,
    asp VARCHAR(40) NOT NULL,
	FOREIGN KEY (asp) REFERENCES ASP_Credentials(asp_name) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Vaccination (
    id_vaccination VARCHAR(20) PRIMARY KEY,
    id_user VARCHAR(16) NOT NULL,
    id_doctor VARCHAR(16), -- null when booked, not-null when vaccination is done
    product VARCHAR(40), -- null when booked, not-null when vaccination is done
	vac_date DATETIME,
    dose_number INT,
	FOREIGN KEY (id_user) REFERENCES Vac_User(fiscal_code) ON DELETE CASCADE,
	FOREIGN KEY (id_doctor) REFERENCES Doctor(fiscal_code) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS User_Credentials (
	fiscal_code VARCHAR(16) PRIMARY KEY,
	password_hash CHAR(128) NOT NULL,
	FOREIGN KEY (fiscal_code) REFERENCES Vac_User(fiscal_code) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Doctor_Credentials (
	fiscal_code VARCHAR(16) PRIMARY KEY,
	password_hash CHAR(128) NOT NULL,
	FOREIGN KEY (fiscal_code) REFERENCES Doctor(fiscal_code) ON DELETE CASCADE
);