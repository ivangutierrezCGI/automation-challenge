ivangutierrezgit@DE-GW75SG3:/mnt/c/Users/ivan.gutierrez/Desktop/automation-challenge/terraform$ curl -v http://localhost
* Host localhost:80 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:80...
* connect to ::1 port 80 from ::1 port 57266 failed: Connection refused
*   Trying 127.0.0.1:80...
* Connected to localhost (127.0.0.1) port 80
> GET / HTTP/1.1
> Host: localhost
> User-Agent: curl/8.5.0
> Accept: */*
>
< HTTP/1.1 403 Forbidden
< Server: nginx/1.29.4
< Date: Wed, 10 Dec 2025 02:12:07 GMT
< Content-Type: text/html
< Content-Length: 153
< Connection: keep-alive
<
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.29.4</center>
</body>
</html>
* Connection #0 to host localhost left intact
ivangutierrezgit@DE-GW75SG3:/mnt/c/Users/ivan.gutierrez/Desktop/automation-challenge/terraform$ curl -v http://automation-challenge.cgi.com
* Host automation-challenge.cgi.com:80 was resolved.
* IPv6: (none)
* IPv4: 127.0.0.1
*   Trying 127.0.0.1:80...
* Connected to automation-challenge.cgi.com (127.0.0.1) port 80
> GET / HTTP/1.1
> Host: automation-challenge.cgi.com
> User-Agent: curl/8.5.0
> Accept: */*
>
< HTTP/1.1 403 Forbidden
< Server: nginx/1.29.4
< Date: Wed, 10 Dec 2025 02:14:16 GMT
< Content-Type: text/html
< Content-Length: 153
< Connection: keep-alive
<
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.29.4</center>
</body>
</html>
* Connection #0 to host automation-challenge.cgi.com left intact









