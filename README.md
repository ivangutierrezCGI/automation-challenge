# Automation Challenge – NGINX + Terraform + Docker (Local + Azure)

This repository contains my solution for the Cloud & DevOps automation challenge:

- Serve a **“Hello CGI!”** page using **NGINX**
- Expose **HTTP (80)** and **HTTPS (443)**
- Handle TLS for a given FQDN (self-signed in this challenge)
- Make static content updateable **without rebuilding the image**
- Automate as much as possible using **Terraform** and **GitHub Actions**
- Deploy locally and (Stage 2) deploy in **Azure** using **ACR + ACI + Storage**

---

## 1) What this repo delivers

### Local (Docker + Terraform)
- NGINX runs in a container.
- HTTP redirects to HTTPS.
- HTTPS uses self-signed TLS cert.
- Static content is mounted as a volume → **edit HTML and refresh** (no rebuild).

### Azure (ACR + ACI + Azure Files)
- Docker image stored in **Azure Container Registry (ACR)**.
- Container runs in **Azure Container Instances (ACI)**.
- Static content and certs come from **Azure Files shares** mounted into the container:
  - `webcontent` → `/usr/share/nginx/html`
  - `nginxcerts` → `/etc/nginx/certs`

### CI (GitHub Actions)
- Build + push Docker image to ACR from GitHub Actions (manual trigger).

---

## 2) Tech stack

- **NGINX** (alpine)
- **Docker Desktop**
- **Terraform** (Docker provider for local)
- **OpenSSL** (self-signed TLS)
- **Azure**: ACR + ACI + Storage Account (Azure Files)
- **GitHub Actions** for CI

---

## 3) Repository structure

```text
automation-challenge/
├── README.md
├── html/
│   └── index.html
├── nginx/
│   ├── Dockerfile
│   ├── default.conf
│   └── entrypoint.sh
├── terraform/
│   ├── main.tf
│   └── .terraform.lock.hcl
└── .github/
    └── workflows/
        ├── ci.yml
        └── build-push-acr.yml
