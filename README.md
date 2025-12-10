/ # cat /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name automation-challenge.cgi.com;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
/ #
