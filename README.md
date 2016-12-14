# Dockerfile-Apache-Reverse-Proxy
To support HTTPS you need SSL certificates, if you already have then customize the path for SSL certificates in dockerfile  otherwise run ssl.sh file before running dockerfile.
```
cd Dockerfile-Apache-Reverse-Proxy
chmod +x ssl.sh  
./ssl.sh
```
Open dockerfile and replace www.example.com with the address of your backend server.
To build dockerfile
```
docker build -t "reverseproxy:apache" .
```
After successful build run proxy container
```
 docker run -it -p 80:80 -p 443:443 reverseproxy:apache /bin/sh
```
