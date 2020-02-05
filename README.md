# opsschool-monitoring

1. Clone this repo.
2. Use the terraform files under /terraform to create an ec2 instance that will be used in class.  
You will need to provide a vpc_id value to create the instance in and a default_keypair_name.
3. Please note the terraform creates your ec2 instance open to the world on 3 ports + ICMP. Please change this to your own IP before class and again during class.
4. Connect to the ec2 instance and clone this repo again, this time to the server.
5. You need to install docker and docker-compose on the server. You can use the script i prepered under /decker to install it for you, or do it your self with ansible or manually.
6. After docker is installed and working properly (You might need to logon-logoff), cd into the /compose directory.
7. From within the compose directory, run the command:
docker-compose up -d  
This will spin up 2 containers, one with prometheus and one with grafana.
8. varify you can access grafana at http://\<you-host-ip-address\>:3000
9. Initial user and password are admin\admin. Please change the password and remember it!
