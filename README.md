# docker-openemm
OpenEMM System dockerized!

### Installation

Pull image:

	docker pull leoqp/openemm
	
### Usage with docker-compose
    openemm:
    	image: serpro/openemm
  	  hostname: localhost.localdomain
	    restart: always
	    ports:
        	- 8080
	    links:
        	- mysql:MYSQL
	        - mail:MAIL
    	environment:
        	- OPEN_EMM_URL=http://emkt.openemm.local
	        - OPEN_EMM_BOUNCE_DOMAIN=emkt.openemm.local  
	        - OPEN_EMM_HOSTNAME=emkt.openemm.local
	        - VIRTUAL_HOST=~^openemm\..* # for rproxy (jwilder/nginx-proxy)
	        - CERT_NAME=default
	        - VIRTUAL_PORT=8080
	        - MYSQL_ROOT_USER=admin
	        - MYSQL_ROOT_PASS=openemm1241343
	        - MYSQL_HOST=mysql
	       	- MYSQL_USER=admin
        	- MYSQL_PASS=openemm1241343
	        - MAIL_USERNAME_AND_PASSWORD='openemm:1234567fsdfsg'
        	- MAIL_ADDRESSES=newsletter info
	#        - 'MAIL_HOST=mx.local'
	#        - 'MAIL_USERNAME_AND_PASSWORD=username:password'

