PS C:\Users\ivan.gutierrez\Desktop\automation-challenge\terraform> ls


    Verzeichnis: C:\Users\ivan.gutierrez\Desktop\automation-challenge\terraform


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        10.12.2025     02:16                .terraform
-a----        10.12.2025     02:16           1337 .terraform.lock.hcl
-a----        10.12.2025     03:20            939 main.tf
-a----        10.12.2025     03:21           6129 terraform.tfstate
-a----        10.12.2025     03:21           6127 terraform.tfstate.backup


PS C:\Users\ivan.gutierrez\Desktop\automation-challenge\terraform> ls -l ../html


    Verzeichnis: C:\Users\ivan.gutierrez\Desktop\automation-challenge\html


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        10.12.2025     01:16            476 index.html

ivangutierrezgit@DE-GW75SG3:/mnt/c/Users/ivan.gutierrez/Desktop/automation-challenge$ docker exec -it nginx-automation sh
/ # ls -l /usr/share/nginx/html
total 0
/ # cat /usr/share/nginx/html/index.html
cat: can't open '/usr/share/nginx/html/index.html': No such file or directory
/ #



La salida de ls -l ../html.

La salida de ls -l /usr/share/nginx/html dentro del contenedor.

Si cat /usr/share/nginx/html/index.html muestra tu HTML con “Hello CGI!”.

Después de cambiar a abspath (y/o mover a ~/automation-challenge), dime si curl http://localhost ya muestra la página correctamente.

Cuando veamos “Hello CGI!” por HTTP, pasamos al siguiente nivel: configurar HTTPS + certificado self-signed para automation-challenge.cgi.com.



docker run -d -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html --name my-nginx-container my-nginx-image


docker exec -it nginx-automation sh
ls -l /usr/share/nginx/html
cat /usr/share/nginx/html/index.html
exit
















