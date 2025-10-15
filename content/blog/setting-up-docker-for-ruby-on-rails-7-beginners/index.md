---
remote_url: https://dev.to/jetthoughts/setting-up-docker-for-ruby-on-rails-7-50cd
source: dev_to
remote_id: 1783325
dev_to_id: 1783325
dev_to_url: https://dev.to/jetthoughts/setting-up-docker-for-ruby-on-rails-7-50cd
title: Setting Up Docker for Ruby on Rails 7
description: 'Introduction:   Docker is essential for modern software development, ensuring a consistent...'
created_at: '2024-03-07T13:14:02Z'
edited_at: '2024-11-25T15:39:29Z'
draft: false
date: 2024-03-07
tags:
- beginners
- ruby
- docker
- postgres
canonical_url: https://jetthoughts.com/blog/setting-up-docker-for-ruby-on-rails-7-beginners/
slug: setting-up-docker-for-ruby-on-rails-7-beginners
---
## Introduction

Docker is essential for modern software development, ensuring a consistent environment and simplifying setup. This article guides you through configuring Docker for Ruby on Rails 7, enhancing workflow efficiency and collaboration.
&nbsp;

## Prerequisites

Before diving into Dockerizing your Ruby on Rails 7 application, ensure you have Docker installed on your system. Below are instructions for installing Docker:

- [for Mac](https://docs.docker.com/desktop/install/mac-install/)
- [for Windows](https://docs.docker.com/desktop/install/windows-install/)
- [for Linux](https://docs.docker.com/desktop/install/linux-install/)

For example to install Docker on Ubuntu, run the following commands in the terminal:

```
sudo apt-get update
sudo apt-get install docker.io
```

Make sure Docker is running and start it with:

```
sudo service docker start
```

Download the prepared repository:

```
git clone https://github.com/Qj7/rails_7_with_docker
```

&nbsp;

## Setting Up Dockerfile

The `Dockerfile` serves as the blueprint for building the Docker image for our Rails application.
It's essential to use only trusted or official base images to ensure the reliability and security of your Docker environment.

Avoid:

```
FROM random-source-from-internet/ruby:3.1.4
```

Instead, opt for:

```
FROM ruby:3.1.4
```

Alternatively, if you have your own image registry:
[How to use own registry](https://www.docker.com/blog/how-to-use-your-own-registry-2/)

```
# Assuming that is your own image registry, which you control entirely
FROM your-own-registry.com/ruby:3.1.4
```

While our current configuration utilizes Ruby version 3.1.4, you have the flexibility to select any Ruby version of your preference. Simply update the version in both the `Gemfile` and `Dockerfile`. Below is an example template:

```
# Use the official Ruby image as the base image
FROM ruby:3.1.4

# Set the working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y nodejs && \
    gem install bundler

# Copy Gemfile and Gemfile.lock to the working directory
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
```

&nbsp;

## Multi-stage setup for `Dockerfile`

Utilizing multi-stage builds in Docker can greatly enhance your Docker workflow. Multi-stage builds allow you to segment your Dockerfile into distinct stages, each serving a specific purpose.

In the first stage, you can focus on building and compiling your application. This stage typically includes installing dependencies, compiling source code, and generating any necessary artifacts.

```
# Stage 1: Build stage
FROM ruby:3.1.4 AS builder

# Set the working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y nodejs

# Copy Gemfile and Gemfile.lock to the working directory
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler && bundle install

# Copy the rest of the application code
COPY . .

# Stage 2: Final stage
FROM ruby:3.1.4

# Set the working directory inside the container
WORKDIR /app

# Copy built application from the builder stage
COPY --from=builder /app .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
```

In our case, implementing multi-stage builds reduced the size of our image from 1.24GB to 998MB, demonstrating the significant reduction in image size achieved through this approach.

&nbsp;

## Multi-container Setup

While the `Dockerfile` allows us to create a container for our application, sometimes a single container is not sufficient for full application functionality. Often, you also need a database or other services, such as a cache storage. For demonstration purposes, we'll set up PostgreSQL as an example. Other popular choices could be `Redis`, `Sidekiq`, or any other service required for your application.
&nbsp;

## Creating Docker Compose Configuration

Docker Compose simplifies the management of multi-container Docker applications. Below is a Docker Compose configuration file `docker-compose.yml` for our Rails and PostgreSQL application:

```
version: '3.8'

services:
  # Service for the Ruby on Rails web application
  web:
    build: .  # Build the service's image from the current directory
    command: bundle exec rails s -p 3000 -b '0.0.0.0'  # Command to start the Rails server
    ports:
      - "3000:3000"  # Expose ports for accessing the application
    volumes:
      - .:/app  # Mount the current directory inside the container
    depends_on:
      - db  # Specify dependency on the database service
    environment:
      DATABASE_URL: postgres://postgres:postgres@db:5432/rails_7_with_docker  # Database connection parameters

  # Service for the PostgreSQL database
  db:
    image: postgres:13  # Use the official PostgreSQL version 13 image
    ports:
      - "5432:5432"  # Expose port for accessing the database
    volumes:
      - postgres_data:/var/lib/postgresql/data  # Create a volume for storing database data
    environment:
      POSTGRES_USER: postgres  # Set the username for database access
      POSTGRES_PASSWORD: postgres  # Set the password for database access

# Define a volume for storing PostgreSQL data
volumes:
  postgres_data:

```

&nbsp;

## Running Docker Containers

With the Dockerfile and Docker Compose configuration in place, we can build and run our Docker containers. Execute the following commands in your terminal:

```
docker-compose build
docker-compose run web rails db:create
docker-compose up
```

&nbsp;

## Accessing the Rails Application

Once the containers are up and running, open a web browser and navigate to <http://localhost:3000> to access your Rails application.
&nbsp;

## Conclusion

We've explored how Docker transforms Ruby on Rails 7 development workflows. By containerizing our Rails application, we ensure consistency, simplify collaboration, and enhance productivity. Embrace Docker in your development journey to streamline your Ruby on Rails projects. Happy coding!

[Add my at LinkedIn ❤️](https://www.linkedin.com/in/vladimir-dolgiy/)
