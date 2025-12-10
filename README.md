# Automation Challenge – NGINX + Terraform + Docker

This repository contains my solution for the **Cloud & DevOps automation challenge**:

> Deploy an NGINX webserver using automation, serve a “Hello CGI!” page over HTTP and HTTPS, handle TLS for a given FQDN, and make static content modifiable without rebuilding the container image. Optionally, add a CI pipeline.

---

## 1. Overview

**Goal**

- Deploy an NGINX web server as a container.
- Expose it on both **HTTP (80)** and **HTTPS (443)**.
- Use a **TLS certificate** for the FQDN `automation-challenge.cgi.com`.
- Allow the **static “Hello CGI!” page** to be changed **without rebuilding the container image**.
- Demonstrate “automation first” mindset using **Terraform** and **GitHub Actions**.

**Key technologies**

- **Docker** – container runtime for NGINX.
- **Terraform** – infrastructure as code using the Docker provider.
- **NGINX** – HTTP/HTTPS web server.
- **OpenSSL** – self-signed TLS certificate.
- **GitHub Actions** – CI pipeline (Terraform fmt/validate + Docker build).
- **Windows 11 + WSL** – local development environment.

---

## 2. Architecture

High-level architecture:

- **Host**: Windows 11 laptop with WSL (Ubuntu), Docker and Terraform installed.
- **Container**:  
  - Image built from `nginx:alpine` with custom config.  
  - Runs as `nginx-automation` container.
- **Terraform (Docker provider)**:  
  - Builds the NGINX image from `./nginx/Dockerfile`.  
  - Creates and manages the container.  
  - Configures **port mappings** and **bind mounts**.

**Networking & FQDN**

- The FQDN `automation-challenge.cgi.com` is resolved locally via the Windows `hosts` file:

  ```text
  127.0.0.1    automation-challenge.cgi.com

####   Docker maps host ports to container ports:

- 80 -> 80 (HTTP)

- 443 -> 443 (HTTPS)

#### Volumes / Bind mounts
##### - Static content:

- Host: ./html

- Container: /usr/share/nginx/html

##### TLS certificates:

- Host: ./certs

- Container: /etc/nginx/certs

##### NGINX configuration:

- Host: ./nginx/default.conf

- Container: /etc/nginx/conf.d/default.conf

Thanks to bind mounts, updating HTML or NGINX configuration does not require rebuilding the Docker image.




AUTOMATION-CHALLENGE/
├── README.MD
├── HTML/
│   └── INDEX.HTML                # "HELLO CGI!" PAGE (STATIC CONTENT)
├── NGINX/
│   ├── DOCKERFILE                # CUSTOM NGINX IMAGE
│   └── DEFAULT.CONF              # NGINX HTTP+HTTPS CONFIG
├── CERTS/
│   ├── AUTOMATION-CHALLENGE.CGI.COM.KEY  # TLS PRIVATE KEY (SELF-SIGNED)
│   └── AUTOMATION-CHALLENGE.CGI.COM.CRT  # TLS CERTIFICATE (SELF-SIGNED)
├── TERRAFORM/
│   ├── MAIN.TF                   # TERRAFORM CONFIG (DOCKER PROVIDER)
│   └── ...                       # TERRAFORM.TFSTATE, ETC.
└── .GITHUB/
       
	   └── WORKFLOWS/
        └── CI.YML                # GITHUB ACTIONS CI PIPELINE
		








