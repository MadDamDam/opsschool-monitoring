Visibility & Alerts  
===================

Welcome to the Opsschool Visibility and Alerts course repo.  
  
![!Visibility](https://media.giphy.com/media/JBuDZwKcyrENW/giphy.gif)

Session 1 Pre-work  
------------------

Here's some pre-session reading, watching, and work for you. Make sure you go over everything and setup the environment before class as we won't have time for setup.  

### Reading List  

1. Read [this intro](https://www.robustperception.io/monitoring-not-just-for-outages) about what monitoring should look like from the excellent Robust Perception blog by the ruthless Brian Brazil.  

2. Read [this post](https://grafana.com/blog/2016/01/05/logs-and-metrics-and-graphs-oh-my/), also by Brian Brazil, from the Grafana blog. It speaks a bit about the difference between Metrics and Logs, and when to use each.  

3. We will be working with Prometheus, a time-series database. Read [this post](https://blog.timescale.com/blog/what-the-heck-is-time-series-data-and-why-do-i-need-a-time-series-database-dcf3b1b18563/) to understand what is a time-series database.  

4. Now that you know a bit about monitoring, let's get into specifics. As i mentioned, we will be working with Prometheus. To learn about Prometheus and what it's good for watch [this short video](https://www.youtube.com/watch?v=cwRmXqXKGtk) by... You guessed it, Brian Brazil.    

5. Complete [this short training](https://www.katacoda.com/courses/prometheus/getting-started) to get a hands on feel of Prometheus and see what it's setup is like.  

### Pre-class Setup

1. Clone this repo.  

2. Use the terraform files under [/terraform](terraform/) to create an ec2 instance that will be used in class.  You will need to provide a `vpc_id` value to create the instance in and a `default_keypair_name`.  
> **Importent:** The terraform creates your ec2 instance open to the world on 3 ports + ICMP. Please change this to your own IP before class and again during class.  

3. Connect to the ec2 instance and clone this repo again, this time to the server.  

4. cd into the [./setup](setup/) directory and install docker and docker-compose on the server.  
You can use the script I prepered ([`inst_docker.sh`](setup/inst_docker.sh)) to install it for you, or do it yourself with ansible or manually.  
After the instalation completes varify you can run docker commands on the host (you might need to logoff-logon).  

5. Install `node_exporter` on the server. `node_exporter` is a utility that exports server metrics (CPU %, memory usage, disk space etc.)  
In class we will feed this data into prometheus, and prometheus will save it over time.  
We want to install `node_exporter` as a systemd service so it will always be available on our instance.  
Run the script [`inst_node_exporter.sh`](setup/inst_node_exporter.sh)) (from within the [./setup](setup/) dir) to do all the heavy lifting for you.  

6. Now that everythings is installed, cd into the [./compose](compose/) directory.  
From within the compose directory, run the command:
```shell
docker-compose up -d
```  
This will spin up 2 containers, one with prometheus and one with grafana.  

7. Varify you can access grafana at http://\<you-host-ip-address\>:3000  
>**Note:** Initial user and password are `admin\admin`. Please change the password and remember it!  

Session 1 Homework  
------------------

1. For the alerting part of the next session we will need a working Gmail account with 2FA enabled. If you don't have a Gmail account already or don't want to enable 2FA on your account (though you probably should) please open a new Gmail account for class. Follow [these steps](https://www.google.com/landing/2step/) to enable 2FA on the account.

2. After enabling 2FA, follow [these instructions](https://myaccount.google.com/apppasswords) to Generate an app password that we will use for Grafana to send mails with (choose type custom). Save this password somewhere safe until the next session.

3. We will be instrumenting python code. Read about the Prometheus Python Client library and Run the Three Step Demo from [the library documentation](https://github.com/prometheus/client_python).

4. Look at ./instrument/mock_python.py. Try and understand the code. In short, it wakes up every 20 seconds and adds a random number to a gauge and counter metric it exposes.

5. run ```docker-compose build``` to build the image, and then ```docker-compose up -d``` to start the mock-python service. try and curl the metrics at port 9200.

6. Add a new job config to your Prometheus config to scrape the mock-python service. Restart Prometheus and make sure it scrapes the new data (by looking at the "targets" page on the Prometheus web interface).

7. Add a new dashboard to your Grafana. The dashboard should include a singlestat panel to show the gauge metric, and a graph panel to show the change in the counter metric per second (Hint: use a function).
