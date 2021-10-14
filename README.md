# Project Information

- Ruby version 2.7.2

- Rails version 6.0.4.1

- Database: Postgresql

# Setup Project

- Run this command and change the config with your local database system

  ```
  cp config/database.yml.example config/database.yml
  ```

- Run this command and change env variables for your local

  ```
  cp .env.example .env
  ```

- Run this command to create database, run migration and sample data

  ```
  rake db:create db:migrate
  ```

- Run this command to apply `credentials.yml` for your local

  ```
  touch config/master.key
  ```
