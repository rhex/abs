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

export JAVA_OPTS="-Dsolr.solr.home=/opt/dev/solrindex"
cp example/solr to tomcat

<Context docBase="/dev/apache-tomcat-7.0.42/webapps/solr" debug="0" crossContext="true" >
    <Environment name="solr/home" type="java.lang.String" value="/dev/solrindex" override="true" />
</Context>

move solr.war to webapps

another way manage/html to deploy(first add <user username="tomcat" password="tomcat" roles="manager-gui"/> to tomcat-user.xml)

./solr is the default

# config with jetty

1 add to solrconfig.xml

<requestHandler name="/dataimport" 
     class="org.apache.solr.handler.dataimport.DataImportHandler">
    <lst name="defaults">
      <str name="config">data-config.xml</str>
    </lst>
</requestHandler>

2 add data-config.xml to solr/conf

3 config schema.xml, name should be the same as that in data-config.xml

4 Add mysql-connector, solr-dataimporter .. to solr lib folder

http://localhost:8080/solr/dataimport?command=full-import

http://localhost:8983/solr/collection1/select?q=title1&wt=json

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

search --config sphinx.conf "xyz"
search -c /etc/sphinxsearch/sphinx.conf -q 1
--noinfo
sudo indexer abs_index
sudo indexer --all
sudo searchd --nodetach

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
# tire
# stretcher
# incremental search
# sphinx rt

h3 Thanks to:

https://github.com/jprante/elasticsearch-river-jdbc/wiki/Quickstart
http://www.elasticsearch.org/guide/reference/api/admin-indices-create-index/
http://www.cnblogs.com/MrHiFiy/archive/2012/12/06/2806221.html


http://sphinxsearch.com/docs/manual-2.0.9.html
http://www.sphinxsearch.org/sphinx-tutorial
http://www.coreseek.cn/docs/coreseek_3.2-sphinx_0.9.9.html#sql

http://wiki.apache.org/solr/SolrInstall
https://cwiki.apache.org/confluence/display/solr/Apache+Solr+Reference+Guide
http://lucene.apache.org/solr/4_4_0/tutorial.html


https://cwiki.apache.org/confluence/display/solr/Running+Solr+on+Tomcat
http://blog.csdn.net/fover717/article/details/7551867
http://blog.csdn.net/xzknet/article/details/6710753
http://wiki.apache.org/solr/FrontPage
http://wiki.apache.org/solr/DIHQuickStart
