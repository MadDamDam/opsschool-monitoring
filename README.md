Visibility & Alerts  
===================

Welcome to the Opsschool Visibility and Alerts course repo.

Lesson 1 Pre-work  
-----------------

Here's some pre-lesson reading, watching, and work for you. Make sure you go over everything and setup the environment before class as we won't have time for setup.  

### Reading List  

1. Read [this intro](https://www.robustperception.io/monitoring-not-just-for-outages) about what monitoring should look like from the excellent Robust Perception blog by the ruthless Brian Brazil.  

2. Read [this post](https://grafana.com/blog/2016/01/05/logs-and-metrics-and-graphs-oh-my/), also by Brian Brazil, from the Grafana blog. It speaks a bit about the difference between Metrics and Logs, and when to use each.  

3. We will be working with Prometheus, a time-series database. Read [this post](https://blog.timescale.com/blog/what-the-heck-is-time-series-data-and-why-do-i-need-a-time-series-database-dcf3b1b18563/) to understand what is a time-series database.  

4. Now that you know a bit about monitoring, let's get into specifics. As i mentioned, we will be working with Prometheus. To learn about Prometheus and what it's good for watch [this short video](https://www.youtube.com/watch?v=cwRmXqXKGtk) by... You guessed it, Brian Brazil.    

5. Complete [this short training](https://www.katacoda.com/courses/prometheus/getting-started) to get a hands on feel of Prometheus and see what it's setup is like.  

### pre-class Setup

1. Clone this repo.  

2. Use the terraform files under /terraform to create an ec2 instance that will be used in class.  You will need to provide a vpc_id value to create the instance in and a default_keypair_name.  
**Importent:** The terraform creates your ec2 instance open to the world on 3 ports + ICMP. Please change this to your own IP before class and again during class.  

3. Connect to the ec2 instance and clone this repo again, this time to the server.  

4. cd into the ./setup directory and install docker and docker-compose on the server.  
You can use the script i prepered (inst_docker.sh) to install it for you, or do it yourself with ansible or manually.  
After the instalation completes varify you can run docker commands on the host (you might need to logoff-logon).  

5. Install node_exporter on the server. node_exporter is a utility that exports server metrics (CPU %, memory usage, disk space etc.)  
In class we will feed this data into prometheus, and prometheus will save it over time.  
We want to install node exporter as a systemd service so it will always be available on our instance.  
Run the script inst_node_exporter.sh (from within the ./setup dir) to do all the heavy lifting for you.  

6. Now that everythings is installed, cd into the ./compose directory.  
From within the compose directory, run the command:  
docker-compose up -d  
This will spin up 2 containers, one with prometheus and one with grafana.  

7. Varify you can access grafana at http://\<you-host-ip-address\>:3000  
Initial user and password are admin\admin. Please change the password and remember it!  
