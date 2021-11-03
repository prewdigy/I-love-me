## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[ELK stack Network diagram.pdf](https://github.com/prewdigy/ELK-stack-project/files/7451867/Network.w_.ELK.stack.drawio.pdf)


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the ELK-stack-project file may be used to install only certain pieces of it, such as Filebeat.

[Install ELK server playbook](https://github.com/prewdigy/I-love-me/files/7465559/install-ELK-server-playbook.txt)

___
[Install filebeat playbook](https://github.com/prewdigy/I-love-me/files/7465561/install-filebeat-playbook.txt)

[Filebeat config file](https://github.com/prewdigy/I-love-me/files/7465567/filebeat-config-as-a-text.txt)

____
[Install metricbeat playbook](https://github.com/prewdigy/I-love-me/files/7465562/install-metricbeat-playbook.txt)

[Metricbeat config file](https://github.com/prewdigy/I-love-me/files/7465566/metricbeat-config-as-a-text.txt)
____
This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly redundant, in addition to restricting access to the network.  Load balancers also assist in security by protecting the site from DDoS attacks due to automatically balancing what ever the incoming traffic is between all the servers attached to it.   

The Jump Box allows for a controlled more secure access to the webservers.  The jump box is a highly secured server only used for adminstrative tasks.  This greatly reduces the vulnerablity of the jump box being compromised by many common activities: email, web browsing, or using other computer applications.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log files and system services.  It does this using file beat and metric beat

The configuration details of each machine may be found below.

| Name            | Function  | IP Address | Operating System |
|-----------------|---------- |------------|------------------|
| Jump Box        | Gateway   | 10.0.0.4   | Linux            |
| Webserver-1     | Webserver | 10.0.0.5   | Linux            |
| Webserver-2     | Webserver | 10.0.0.6   | Linux            |
| ELK Stack       | Data logs | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from a specified IP address using the Inbound rules of security group

Machines within the network can only be accessed by the Jump Box machine.

A summary of the access policies in place can be found in the table below and listed in the rules on page 2 and 4 of the pdf

| Name         | Publicly Accessible | Allowed IP Addresses     |
|--------------|---------------------|--------------------------|
| Jump Box     | Yes                 | based on security group  |
| Webserver1:2 | No                  | 10.0.0.4                 |
| Elk Stack    | Yes                 | based on security group  |

## Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it reduces the cost of labor, simplifies and speeds up the integration process when new machines/equipment are purchased, reduces human error, and increases disaster recory speed.

The playbook implements the following tasks:
- Installs Docker then Python3
- Installs Docker module using pip
- Increases the virtual memory in the system and then tells the system that it has that much more virtual memory to use.   This is important other wise docker will not run properly
- Downloads and runs the ELK container, setting to to start up during boot up, and publishing 3 different ports for UDP and TCP use (5601, 9200, and 5044)

Running 'docker ps` on the ELK stack machine after successfully configuring the ELK instance should have an output similar to this
```
CONTAINER ID   IMAGE                 COMMAND                  CREATED       STATUS         PORTS                                                                             NAMES
5f7b8ad9eb4f   sebp/elk:761          "/usr/local/bin/star…"   10 days ago   Up 5 minutes   0.0.0.0:5044->5044/tcp, 0.0.0.0:5601->5601/tcp, 0.0.0.0:9200->9200/tcp, 9300/tcp   elk
f5ab0d801344   cyberxsecurity/dvwa   "/main.sh"               10 days ago   Up 5 minutes   0.0.0.0:80->80/tcp                                                                 dvwa
```

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Webserver-1 10.0.0.5
- Webserver-2 10.0.0.6

We have installed the following Beats on these machines:
- File beat
- Metric beat

These Beats allow us to collect the following information from each machine:

- Filebeat is a lightweight shipper for forwarding and centralizing log data. Installed as an agent on your servers, Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.

- Metricbeat takes the metrics and statistics that it collects and ships them to the output that you specify, such as Elasticsearch or Logstash. Metricbeat helps you monitor your servers by collecting metrics from the system and services running on the server.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the metricbeat and filebeat .yml files to /etc/ansible/roles.
- Copy the metricbeat-config.yml file to /etc/ansible/files.  Make sure that the IP address for both the Kibana and Elasticsearch output are the private IP address of your ELK stack.  Kibana is usually handled on port 5601, and Elasticsearch on port 9200.
- Copy the filebeat-config.yml ile to /etc/ansible/files. Make sure that the IP address for both the Kibana, line 1106, and Elasticsearch output, line 1806, are the private IP address of your ELK stack. Kibana is usually handled on port 5601, and Elasticsearch on port 9200.
- Update the hosts file to include the local IP addresses of the servers to be updated specified under [elk]
- Run the playbook, and navigate to [http://public_IP_for_ELK:5601/app/kibana] to check that the installation worked as expected.
