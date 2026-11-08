CREATE DATABASE IF NOT EXISTS cleaning_mini
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS teams (
    team_id INT AUTO_INCREMENT NOT NULL,
    team_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (team_id));
    
CREATE TABLE IF NOT EXISTS workers (
    worker_id INT AUTO_INCREMENT NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    worker_email VARCHAR(100) NOT NULL,
    worker_skill VARCHAR(50) NOT NULL,
	team_id INT NOT NULL,
    PRIMARY KEY (worker_id),
    
    CONSTRAINT fk_worker_team
      FOREIGN KEY(team_id)
      REFERENCES teams(team_id)
	ON DELETE CASCADE
      ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT NOT NULL,
    customer_name VARCHAR(50) NOT NULL,
    phone_num VARCHAR(15) NOT NULL,
    address VARCHAR (100) NOT NULL,
    PRIMARY KEY (customer_id));
    
CREATE TABLE IF NOT EXISTS jobs (
    job_id INT AUTO_INCREMENT NOT NULL,
    scheduled_at DATETIME NOT NULL,
    job_status VARCHAR(50) NOT NULL ,
    service_address VARCHAR (100) NOT NULL,
    customer_id INT NOT NULL,
    worker_id INT NOT NULL,
    PRIMARY KEY (job_id),
    
    CONSTRAINT fk_customer_job
      FOREIGN KEY(customer_id)
      REFERENCES customers(customer_id)
	ON DELETE CASCADE
      ON UPDATE CASCADE,
	
    CONSTRAINT fk_worker_job
      FOREIGN KEY(worker_id)
      REFERENCES workers(worker_id)
	ON DELETE CASCADE
      ON UPDATE CASCADE,
      
	CONSTRAINT chk_jobs_status
        CHECK (job_status IN ('Pending', 'Completed', 'Cancelled'))
);

CREATE TABLE IF NOT EXISTS acceptance_records (
    record_id INT AUTO_INCREMENT NOT NULL,
    area_m2 DECIMAL(10,2) NOT NULL,
	work_summary VARCHAR(50) NOT NULL ,
    accepted_at DATETIME NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    job_id INT NOT NULL,
    PRIMARY KEY (record_id),
	CONSTRAINT uq_acceptance_job UNIQUE (job_id),
    
    CONSTRAINT fk_acceptance_job
      FOREIGN KEY(job_id)
      REFERENCES jobs(job_id)
	ON DELETE CASCADE
      ON UPDATE CASCADE,
      
	CONSTRAINT chk_acceptance_area_positive 
      CHECK (area_m2 > 0),
      
	CONSTRAINT chk_chk_acceptance_cost
      CHECK (cost >= 0)
);
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_date DATETIME NOT NULL,
    method ENUM('Cash','BankTransfer','Card') NOT NULL,
    job_id INT NOT NULL,
    PRIMARY KEY (payment_id),
	
    CONSTRAINT fk_payment_job
      FOREIGN KEY(job_id)
      REFERENCES jobs(job_id)
	ON DELETE CASCADE
      ON UPDATE CASCADE,
	
    CONSTRAINT chk_amount
      CHECK (amount>0)
);

