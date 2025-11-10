CREATE TABLE countries (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE cities (
  id INT AUTO_INCREMENT PRIMARY KEY,
  country_id INT NOT NULL,
  name VARCHAR(120) NOT NULL,
  CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES countries(id),
  UNIQUE(country_id, name)
) ENGINE=InnoDB;

CREATE TABLE hotels (
  id INT AUTO_INCREMENT PRIMARY KEY,
  city_id INT NOT NULL,
  name VARCHAR(150) NOT NULL,
  stars TINYINT NOT NULL,
  CONSTRAINT fk_hotel_city FOREIGN KEY (city_id) REFERENCES cities(id),
  CHECK (stars BETWEEN 1 AND 5),
  UNIQUE(city_id, name)
) ENGINE=InnoDB;

CREATE TABLE services (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL UNIQUE,
  base_price DECIMAL(10,2) NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE tours (
  id INT AUTO_INCREMENT PRIMARY KEY,
  hotel_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  seats_total INT NOT NULL,
  seats_left INT NOT NULL,
  CONSTRAINT fk_tour_hotel FOREIGN KEY (hotel_id) REFERENCES hotels(id),
  CHECK (end_date >= start_date),
  INDEX idx_tours_dates (start_date, end_date),
  INDEX idx_tours_hotel (hotel_id)
) ENGINE=InnoDB;
