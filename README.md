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

		
4. Requirements

On the local machine:

Windows 11 with WSL (Ubuntu or similar).

Docker installed and running.

Terraform ≥ v1.14.x.

OpenSSL (available in WSL).

Git and a GitHub repository (for CI).

5. How to run the solution locally
5.1. Clone the repository
git clone <your-repo-url> automation-challenge
cd automation-challenge


In this setup, the project lives in C:\Users\<user>\Desktop\automation-challenge on Windows and is accessible in WSL via /mnt/c/....

5.2. Configure the local FQDN

On Windows, edit the hosts file:

Open C:\Windows\System32\drivers\etc\hosts as Administrator.

Add:

127.0.0.1    automation-challenge.cgi.com


Save and close.

5.3. Generate the self-signed certificate (in WSL)

From WSL:

cd /mnt/c/Users/<your-user>/Desktop/automation-challenge/certs

openssl req -x509 -nodes -newkey rsa:2048 \
  -keyout automation-challenge.cgi.com.key \
  -out automation-challenge.cgi.com.crt \
  -days 365 \
  -subj "/CN=automation-challenge.cgi.com"


This creates:

automation-challenge.cgi.com.key

automation-challenge.cgi.com.crt

5.4. Start the NGINX container using Terraform

From PowerShell on Windows:

cd "C:\Users\<your-user>\Desktop\automation-challenge\terraform"

terraform init
terraform apply
# Type "yes" when prompted


Terraform will:

Build the Docker image nginx-automation:latest from ./nginx/Dockerfile.

Start a container named nginx-automation.

Map ports 80 and 443.

Mount the html, certs, and default.conf paths into the container.

To check:

docker ps
# You should see nginx-automation with 0.0.0.0:80->80 and 0.0.0.0:443->443

6. NGINX configuration (HTTP + HTTPS)

The file nginx/default.conf configures:

HTTP (port 80): redirect to HTTPS.

HTTPS (port 443): serve the static site using the self-signed certificate.

Example:

# HTTP: redirect everything to HTTPS
server {
    listen 80;
    server_name automation-challenge.cgi.com;

    return 301 https://$host$request_uri;
}

# HTTPS: serve the site with TLS
server {
    listen 443 ssl;
    server_name automation-challenge.cgi.com;

    ssl_certificate     /etc/nginx/certs/automation-challenge.cgi.com.crt;
    ssl_certificate_key /etc/nginx/certs/automation-challenge.cgi.com.key;

    ssl_protocols       TLSv1.2 TLSv1.3;
    ssl_ciphers         HIGH:!aNULL:!MD5;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}

7. Accessing the site
HTTP

Browser:
http://automation-challenge.cgi.com

HTTPS

Browser:
https://automation-challenge.cgi.com

Since the certificate is self-signed, most browsers will show a security warning such as “Your connection is not private”.
You can proceed by clicking on Advanced → Continue to automation-challenge.cgi.com (unsafe) (unless restricted by corporate policy).

Using curl (WSL):

curl -v https://automation-challenge.cgi.com -k


The -k flag tells curl to accept the self-signed certificate.
You should see:

A successful TLS handshake (TLSv1.2/1.3).

HTTP/1.1 200 OK.

The HTML of the “Hello CGI!” page.

8. Updating static content without rebuilding

The HTML content is bind-mounted:

Host: ./html/index.html

Container: /usr/share/nginx/html/index.html

To update the page:

Edit html/index.html on the host:

<h1>Hello CGI! (v2)</h1>


Save the file.

Refresh the browser or re-run curl:

curl -v https://automation-challenge.cgi.com -k


No docker build, no terraform apply is required.
This demonstrates that static content changes do not require rebuilding the image.

9. CI pipeline (GitHub Actions)

The file .github/workflows/ci.yml defines a simple CI workflow:

Triggered on push and pull_request to the main branch.

Jobs:

Checkout the repository.

Set up Terraform.

Run terraform fmt -check and terraform validate.

Run docker build for the NGINX image.

Example workflow:

name: CI - Automation Challenge

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build-and-validate:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.14.1

      - name: Terraform fmt
        working-directory: ./terraform
        run: terraform fmt -check

      - name: Terraform validate
        working-directory: ./terraform
        run: terraform validate

      - name: Build Docker image for NGINX
        working-directory: ./nginx
        run: docker build -t nginx-automation-ci:latest .


This shows how the solution can be integrated into a CI process, even if the final terraform apply is executed locally.

10. Troubleshooting

Port 80/443 already in use

Adjust the external port in terraform/main.tf, e.g. 8080 instead of 80/443.

Browser cannot “proceed” after HTTPS warning

On some corporate laptops, browser policies prevent bypassing self-signed certificates.

In that case, HTTPS can still be demonstrated via curl -v https://automation-challenge.cgi.com -k.

Changes in default.conf not reflected

The file is bind-mounted into the container.

Check that Terraform has applied changes (terraform apply).

Validate inside the container:

docker exec -it nginx-automation sh
cat /etc/nginx/conf.d/default.conf

11. Possible improvements

Use a real domain and Let’s Encrypt instead of a self-signed certificate.

Use a remote Docker host or Kubernetes cluster instead of local Docker.

Extend the GitHub Actions pipeline to:

Run tests.

Push images to a container registry.

Trigger deployment steps in a more advanced environment.








