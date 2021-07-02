The repository contains a simple server & client that connect and send data to each other. The connection is encrypted, with end-to-end authentication with self-signed certificates. The server is in Matlab and the client in python. The Matlab server uses python code in it.

Commands to generate certificate/keys for client and server:
1. openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout server.key -out server.crt
2. openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout client.key -out client.crt