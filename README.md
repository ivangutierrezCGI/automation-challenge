PS C:\Users\ivan.gutierrez\Desktop\automation-challenge\terraform> curl -v http://automation-challenge.cgi.com
AUSFÜHRLICH: GET with 0-byte payload
AUSFÜHRLICH: received 476-byte response of content type text/html


StatusCode        : 200
StatusDescription : OK
Content           : ÿþ<!DOCTYPE html>
                    <html lang=
                    en>
                    <head>
                        <meta charset=UTF-8>
                        <title>Hello CGI!</title>
                    </he...
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 476
                    Content-Type: text/html
                    Date: Wed, 10 Dec 2025 19:45:15 GMT
                    ETag: "6938bbc2-1dc"
                    Last-Modified: Wed, 10 Dec 2025 ...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 476], [Content-Type, text/html]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 476



PS C:\Users\ivan.gutierrez\Desktop\automation-challenge\terraform> curl -v https://automation-challenge.cgi.com -k
Invoke-WebRequest : Es wurde kein Parameter gefunden, der dem Parameternamen "k" entspricht.
In Zeile:1 Zeichen:46
+ curl -v https://automation-challenge.cgi.com -k
+                                              ~~
    + CategoryInfo          : InvalidArgument: (:) [Invoke-WebRequest], ParameterBindingException
    + FullyQualifiedErrorId : NamedParameterNotFound,Microsoft.PowerShell.Commands.InvokeWebRequestCommand

PS C:\Users\ivan.gutierrez\Desktop\automation-challenge\terraform>
