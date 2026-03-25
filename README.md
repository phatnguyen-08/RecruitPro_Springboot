# RecruitPro - Spring Boot Recruitment Platform

A full-stack recruitment platform built with Spring Boot, MySQL, and Thymeleaf.

## Prerequisites

- Java 17+
- Maven 3.8+
- MySQL 8.0+

## Setup Instructions

### 1. Create Database

Before running the application, you need to create the MySQL database:

```sql
CREATE DATABASE recruitment_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2. Configure Database Credentials

Edit `src/main/resources/application.properties` to match your MySQL credentials:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/recruitment_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
```

### 3. Run the Application

```bash
./mvnw spring-boot:run
```

The application will:
- Automatically create all database tables (via Hibernate)
- Load sample data from `data.sql` (job fields, users, companies, job postings, etc.)

### 4. Access the Application

Open your browser and navigate to: http://localhost:8080

## Sample Login Accounts

| Email | Password | Role |
|-------|----------|------|
| recruiter@techviet.com | password123 | RECRUITER |
| candidate@email.com | password123 | CANDIDATE |
| admin@recruitpro.com | password123 | ADMIN |

## Features

- **Homepage**: Browse job listings with search and filter by job field
- **Job Details**: View detailed job information and apply
- **Candidate Profile**: Manage profile, upload CV, track applications
- **Recruiter Dashboard**: Post jobs, manage applications, schedule interviews
- **Job Field (Ngành nghề)**: Filter jobs by industry/field

## Tech Stack

- Spring Boot 3.5
- Spring Security with JWT
- Spring Data JPA / Hibernate
- MySQL 8
- Thymeleaf (server-side rendering)
- Bootstrap 5 (frontend)
