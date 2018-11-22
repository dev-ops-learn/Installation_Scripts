## Installation and Configuration of Monit
### About Monit
`Monit` is a small utility for managing and monitoring Unix systems. Monit conducts automatic maintenance and repair and can execute meaningful causal actions in error situations.

### Install Monit
Monit is easiest to install through `YUM`
```
sudo yum install monit
```

Once monit downloads, you can add programs and processes to the configuration file:
```
sudo vi /etc/monitrc
```

Monit can be started up with a command that then keeps it running in the background
```
service monit start
```
Typing `monit status` displays monit’s details:

```
Monit 5.25.1 uptime: 5d 4h 49m

Process 'nginx'
  status                       OK
  monitoring status            Monitored
  monitoring mode              active
  on reboot                    start
  pid                          128007
  parent pid                   1
  uid                          0
  effective uid                0
  gid                          0
  uptime                       2h 8m
  threads                      1
  children                     8
  cpu                          0.0%
  cpu total                    0.0%
  memory                       0.0% [2.2 MB]
  memory total                 0.1% [39.8 MB]
  security attribute           system_u:system_r:httpd_t:s0
  data collected               Mon, 06 Aug 2018 13:01:16
  ```
  ### Configure Monit
  Monit is very easy to use nearly out of the box. By default, it is set up to check that services are running every 30 seconds and stores its log file in `/var/log/monit.log`.
  
  ### Web Service
  Monit comes with it’s own web server running on port 2812. To configure the web interface, find and uncomment the section that begins with set httpd port 2812. 
  Once the section is uncommented, write in your server’s IP or domain name as the address, allow anyone to connect, and then create a monit user and password
  ```
  set httpd port 2812
    use address hc4t02442.itcs.hpecorp.net  # only accept connection from localhost
    allow 0.0.0.0/0.0.0.0        # allow localhost to connect to the server and
    allow admin:monit      # require user 'admin' with password 'monit'
  ```
  Once this is configured, monit should reload and reread the configuration file, and the web interface will be available:
  ```
  monit reload
  ```
  You will then be able to access the monit web interface by going to `hc4t02442.itcs.hpecorp.net:2812`
  
  Login with your chosen username and password. Your screen should look something.
  
  ### Configuring Services Self-Monitoring
  
  Once the web services are set up, you can begin to input the programs that you want monitored and protected into the "/etc/monitrc" configuration file. To simply ensure that programs stay online, you can use the /etc/init.d commands to stop or start a program.

  Here are some example configurations:
  
  #### Apache:
  ```
  check process Apache_Server  with pidfile /var/run/httpd/httpd.pid
      if not exist for 10 cycles then alert
  ```
  
  #### Nginx:
  ```
  check process nginx with pidfile /var/run/nginx.pid
      if not exist for 10 cycles then alert
  ```
  #### Entmon Service [Example `entmon-service`]
  ```
  check process entmon-service with pidfile /etc/monit.d/entmonservice.pid
      if not exist for 20 cycles then alert
  ```
  #### File System [Example `mount1`]
  ```
  check filesystem Mount1 path /opt/mount1
                if space usage > 90% for 20 cycles then alert
  ```
  #### Health Check
  ```
  check host Spark_Dev_Server with address hc4t03891.itcs.hpecorp.net
   if failed url https://hc4t03891.itcs.hpecorp.net:8443/index.htm for 20 cycles then alert
   if failed ping within 20 cycles then alert
   if failed port 22  protocol ssh  within 20 cycles then alert
  ```
  ### Finish Up
  Once you have set up the configuration, check the syntax:
  ```
  monit -t
  ```
  After resolving any possible syntax errors, you can start running all of the monitored programs.
  ```
  service monit restart
  ```
  ### Reference 
  **[Refer the Configuration file](https://github.hpe.com/reddam-anand-reddy/deployments/blob/master/Monit_Scripts)** to get started with the Monit.
  
  

  
  
  
  
