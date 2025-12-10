ivangutierrezgit@DE-GW75SG3:/mnt/c/Users/ivan.gutierrez/Desktop/automation-challenge$ curl -v https://automation-challenge.cgi.com -k
* Host automation-challenge.cgi.com:443 was resolved.
* IPv6: (none)
* IPv4: 127.0.0.1
*   Trying 127.0.0.1:443...
* Connected to automation-challenge.cgi.com (127.0.0.1) port 443
* ALPN: curl offers h2,http/1.1
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384 / X25519 / RSASSA-PSS
* ALPN: server accepted http/1.1
* Server certificate:
*  subject: CN=automation-challenge.cgi.com
*  start date: Dec 10 19:30:04 2025 GMT
*  expire date: Dec 10 19:30:04 2026 GMT
*  issuer: CN=automation-challenge.cgi.com
*  SSL certificate verify result: self-signed certificate (18), continuing anyway.
*   Certificate level 0: Public key type RSA (2048/112 Bits/secBits), signed using sha256WithRSAEncryption
* using HTTP/1.x
> GET / HTTP/1.1
> Host: automation-challenge.cgi.com
> User-Agent: curl/8.5.0
> Accept: */*
>
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* old SSL session ID is stale, removing
< HTTP/1.1 200 OK
< Server: nginx/1.29.4
< Date: Wed, 10 Dec 2025 20:40:57 GMT
< Content-Type: text/html
< Content-Length: 476
< Last-Modified: Wed, 10 Dec 2025 00:16:02 GMT
< Connection: keep-alive
< ETag: "6938bbc2-1dc"
< Accept-Ranges: bytes
<
Warning: Binary output can mess up your terminal. Use "--output -" to tell
Warning: curl to output it to your terminal anyway, or consider "--output
Warning: <FILE>" to save to a file.
* Failure writing output to destination
* Closing connection
* TLSv1.3 (OUT), TLS alert, close notify (256):
