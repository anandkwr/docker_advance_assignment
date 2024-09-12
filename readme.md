# Docker Advanced Assignment

This project demonstrates advanced Docker concepts including Dockerfile optimization, custom networks, volume management, security best practices, and log aggregation. The application is a Dockerized CRUD application using Spring Boot and MySQL.

## Table of Contents

1. [Dockerfile Optimization](#dockerfile-optimization)
2. [Custom Network Configuration](#custom-network-configuration)
3. [Volume Management](#volume-management)
4. [Database Backup and Restore](#database-backup-and-restore)
5. [Security Best Practices](#security-best-practices)
6. [Image Vulnerability Scanning](#image-vulnerability-scanning)
7. [Secret Management](#secret-management)
8. [Docker Security Auditing](#docker-security-auditing)
9. [Log Aggregation System](#log-aggregation-system)
10. [Project Repository and Setup](#project-repository-and-setup)

## Dockerfile Optimization

1. The Dockerfile is optimized using a multi-stage build to reduce image size and improve build speed.
2. Files that are not used in the build process are ignored.

## Custom Network Configuration

1. A custom Docker network named `docker_custom_network` was created using the command:

    ```bash
    docker network create docker_custom_network
    ```

2. To inspect and manage the custom network, use the command:

    ```bash
    docker network inspect docker_custom_network
    ```

3. The `docker-compose.yml` file is updated to connect multiple containers to this custom network.

## Volume Management

1. A Docker volume named `studentcrud_mysql-data` was created to persist MySQL data.

2. To list and inspect volumes, run the commands:

    ```bash
    docker volume ls
    docker volume inspect studentcrud_mysql-data
    ```

3. Named volumes are used for MySQL data persistence, and bind mounts are used for accessing code and secrets. Changes were made in `docker-compose.yml` to implement this.

## Database Backup and Restore

1. To take a database backup, run the following command:

    ```bash
    docker run --rm -v studentcrud_mysql-data:/backup-volume -v "$(pwd)":/backup busybox tar -zcvf /backup/my-backup.tar.gz /backup-volume
    ```

2. To restore the backup, create a new volume and use the following command:

    ```bash
    docker volume create restored_mysql-data
    docker run --rm -v restored_mysql-data:/backup-volume -v $(pwd):/backup busybox tar xvf /backup/my-backup.tar.gz -C /backup-volume --strip 1
    ```

## Security Best Practices

1. A non-root user is created to prevent the application from running with root privileges, reducing potential security risks. Changes are made in the `docker-compose.yml` file for this non-root user implementation.
2. Docker is configured to run containers with the least privilege by using a non-root user and a slim image.

## Image Vulnerability Scanning

1. To scan for image vulnerabilities, use the command:

    ```bash
    docker scan studentcrud_app:latest
    ```

2. Alternatively, use Trivy to check image vulnerabilities:

    ```bash
    trivy image studentcrud_app:latest
    ```

## Secret Management

1. Secret management is introduced to manage sensitive data such as passwords, API keys, and certificates. Secrets are created using the following command:

    ```bash
    echo "Anand@1234" > mysql_root_password.txt
    ```

2. The secret (`mysql_root_password`) is then used in the `docker-compose.yml` file.

## Docker Security Auditing

1. Docker Bench for Security is used to audit the Docker environment. Run the following command:

    ```bash
    docker run -it --net host --cap-add audit_control --label docker_bench_security docker/docker-bench-security
    ```

## Log Aggregation System

1. Prometheus and Grafana are used to implement a log aggregation and monitoring system.
2. To run the log utilities, use the following commands:

    ```bash
    docker-compose -f docker-compose.prometheus.yml up -d
    docker-compose -f docker-compose.grafana.yml up -d
    ```

3. Open Grafana in your browser at [http://localhost:3000](http://localhost:3000) and log in using `admin` as both the username and password.

## Project Repository and Setup

The project is hosted on GitHub: [docker_advance_assignment](https://github.com/anandkwr/docker_advance_assignment).

To run the project:

1. Navigate to the directory where the `Dockerfile` and `docker-compose.yml` files are located.
2. Build the Docker images:

    ```bash
    docker-compose build
    ```

3. Run the application:

    ```bash
    docker-compose up -d
    ```

Feel free to explore the repository for more details on how each step is implemented.
