# Run the following command to genrate certificates in this folder (make sure the paths are correct):
sudo openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
  -keyout ~/opsschool-monitoring/compose/nginx/certs/server.key \
  -out ~/opsschool-monitoring/compose/nginx/certs/server.crt