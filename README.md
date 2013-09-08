abs
===

example to learn angularjs bootstrap search engine(Solor, Sphinx, ElasticSearch)

h3 angularjs

wget http://code.angularjs.org/1.0.7/angular-1.0.7.zip

h3 bootstrap

wget http://getbootstrap.com/2.3.2/assets/bootstrap.zip

h3 jquery

bootsrap need this

wget http://code.jquery.com/jquery-1.10.2.js

h3 angular-ui

wget https://github.com/angular-ui/bootstrap/blob/gh-pages/ui-bootstrap-tpls-0.5.0.js

h3 install solr 

wget http://apache.mesi.com.ar/lucene/solr/4.4.0/solr-4.4.0.zip
wget http://apache.mirrors.hoobly.com/tomcat/tomcat-7/v7.0.42/bin/apache-tomcat-7.0.42.zip
to install tomcat: chmod +x *.sh
in bashrc export CATALINA_HOME=$HOME/dev/apache-tomcat-7.0.42
./startup.sh

A simple way:
in example:  java -jar start.jar

h3 install elasticsearch

dpkg -i
http://127.0.0.1:9200/
install plugin:
/usr/share/elasticsearch$ sudo bin/plugin -install elasticsearch/elasticsearch-river-rabbitmq/1.6.0
install maven:
wget http://www.interior-dsgn.com/apache/maven/maven-3/3.1.0/binaries/apache-maven-3.1.0-bin.tar.gz
cd directory: mvn package
install xxx --install river-mysql --url file:/// Elasticsearch-MySQL-River/target/releases/rivers-mysql-1.0.0-SNAPSHOT.zip
sudo wget http://jdbc.postgresql.org/download/postgresql-9.1-903.jdbc4.jar to the jdbcplugin folder

curl -XPUT 'localhost:9200/_river/my_jdbc_river/_meta' -d '{    "type" : "jdbc",    "jdbc" : {        "driver" : "com.mysql.jdbc.Driver",        "url" : "jdbc:mysql://localhost:3306/abs",        "user" : "sinatra",        "password" : "",        "sql" : "select * from books"    },    "index" : {        "index" : "jdbc",        "type" : "jdbc"    } }'

curl -XGET 'localhost:9200/jdbc/jdbc/_search?pretty&q=*'

h3 install sphinxsearch

dpkg -i

h3 reference

# angularjs

https://github.com/angular/angular.js
http://docs.angularjs.org/misc/started
http://docs.angularjs.org/guide/concepts
http://docs.angularjs.org/tutorial/index
http://zouyesheng.com/angular.html

# bootstrap

http://www.bootcss.com/getting-started.html
https://github.com/twbs/bootstrap

h3 TODO

#http://www.bootcss.com/p/buttons/

# use rake to run seed

h3 Thanks to:

https://github.com/jprante/elasticsearch-river-jdbc/wiki/Quickstart
