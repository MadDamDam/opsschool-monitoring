# opsschool-monitoring

1. Clone this repo.
2. Use the terraform files under /terraform to create an ec2 instance that will be used in class.  
You will need to provide a vpc_id value to create the instance in and a default_keypair_name.
3. Please note the terraform creates your ec2 instance open to the world on 3 ports + ICMP. Please change this to your own IP before class and again during class.
4. Connect to the ec2 instance and clone this repo again, this time to the server.
5. cd into the ./setup directory.
6. Install docker and docker-compose on the server.  
You can use the script i prepered (inst_docker.sh) to install it for you, or do it yourself with ansible or manually.
After the instalation completes varify you can run docker commands on the host (you might need to logoff-logon).
7. Install node_exporter on the server. node_exporter is a utility that exports server metrics (CPU % memory usage, disk space etc.)  
In class we will feed this data into prometheus, and prometheus will save it over time.  
We want to install node exporter as a systemd service so it will always be available on our instance.  
Run the script inst_node_exporter.sh (from within the ./setup dir) to do all the heavy lifting for you.
8. Now that everythings is installed, cd into the ./compose directory.
9. From within the compose directory, run the command:  
docker-compose up -d  
This will spin up 2 containers, one with prometheus and one with grafana.
10. varify you can access grafana at http://\<you-host-ip-address\>:3000
11. Initial user and password are admin\admin. Please change the password and remember it!
