# docker-openemm
Sistema Openemm Dockerizado

## Pré-requisitos

1. Em sistemas Gnu/Linux, certificar-se de que o Docker está instalado e corretamente configurado em sua distribuição. 

## Instalação

1. Construir a imagem:

``` 
$docker build -t custom/openemm .

``` 

- [x] Não esquecer do ponto no final do comando

```
Obs: 
Este processo utilizará o conjunto de procedimentos descritos no arquivo Dockerfile para construir a imagem custom/openemm. 

```


2. Certificar-se de que há o arquivo docker-compose.yaml no diretório corrente, com o conteúdo abaixo:

##### docker-compose.yaml
    openemm:
    	image: custom/openemm
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
	   mysql:
	       restart: always
  	     image: tutum/mysql
    	   volumes:
      	    - mysql:/var/lib/mysql
       	environment:
         	 - MYSQL_PASS=openemm1241343	
	
## Procedimentos

1. Subir os conteineres, utilizando o procedimento a seguir:

```
$docker-compose up

```

2. Certificar-se de que o docker-compose foi executado no ambiente. Em outro terminal, acesse o diretório onde os arquivos foram clonados e uUtilize o procedimento abaixo para inspecionar:

```
$docker-compose ps

```

3. Verifique a porta traduzida dinamicamente para a porta 8080 do Tomcat, onde a aplicação é executada, vide exemplo abaixo:

```

```


