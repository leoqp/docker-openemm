# docker-openemm
Sistema Openemm Dockerizado

## Pré-requisitos

1. Em sistemas Gnu/Linux, certificar-se de que o Docker está instalado e corretamente configurado em sua distribuição. 

> *É sugerida a documentação do link abaixo, no caso de sistemas Debian/Ubuntu:*

[Documentação Oficial Docker](https://docs.docker.com/engine/installation/linux/ubuntu/).

2. Clonar o projeto utilizando o git ou baixando os arquivos do repositório, conforme indicado:

$git clone [url]

> *Para mais informações, consultar as urls a seguir:

[Instalando o git](https://git-scm.com/book/pt-br/v1/Primeiros-passos-Instalando-Git).

[Clonando um repositório existente](https://git-scm.com/book/pt-br/v1/Git-Essencial-Obtendo-um-Reposit%C3%B3rio-Git#Clonando-um-Reposit%C3%B3rio-Existente).


## Instalação

1. Construir a imagem:

``` 
$docker build -t custom/openemm .
``` 

*Não esquecer do ponto no final do comando*

```
Este processo utilizará o conjunto de procedimentos descritos no arquivo Dockerfile. 
```


2. Certificar-se de que existe o arquivo docker-compose.yml no diretório corrente, com o conteúdo abaixo:

##### docker-compose.yml
    openemm:
    	image: custom/openemm
  	hostname: localhost.localdomain
	restart: always
	ports:
           - 8080
           - 25
	links:
           - mysql:MYSQL
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
          Name                       Command               State                       Ports                      
----------------------------------------------------------------------------------------------------------------
2015r3serpro_mysql_1     /run.sh                          Up      3306/tcp                                       
2015r3serpro_openemm_1   /usr/bin/supervisord -c /e ...   Up      0.0.0.0:32772->25/tcp, 0.0.0.0:32771->8080/tcp 
```

> *Neste caso, a porta 32770 foi utilizada para traduzir a porta 8080 do conteiner WEB*

4. Acessar a URL da aplicação utilizando o endereço e a porta traduzida:

```
http://localhost:32771 
```

