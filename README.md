# Automation Challenge

PS C:\Users\ivan.gutierrez\Desktop\automation-challenge\terraform> terraform apply
╷
│ Error: Error pinging Docker server: error during connect: In the default daemon configuration on Windows, the docker client must be run with elevated privileges to connect.: Get "http://%2F%2F.%2Fpipe%2Fdocker_engine/_ping": open //./pipe/docker_engine: Das System kann die angegebene Datei nicht finden.
│
│   with provider["registry.terraform.io/kreuzwerker/docker"],
│   on main.tf line 10, in provider "docker":
│   10: provider "docker" {
│
╵
PS C:\Users\ivan.gutierrez\Desktop\automation-challenge\terraform>








