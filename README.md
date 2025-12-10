# Automation Challenge

FROM nginx:alpine

# Remove default config to avoid conflicts
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom config
COPY default.conf /etc/nginx/conf.d/default.conf

# We'll serve static files from /usr/share/nginx/html
# but the content will come from a mounted volume (host -> container),
# so we don't need to COPY the html here.

EXPOSE 80
# 443 will be used later for HTTPS

CMD ["nginx", "-g", "daemon off;"]




