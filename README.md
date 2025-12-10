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

    # Paths inside the container (we los montaremos con Terraform)
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
