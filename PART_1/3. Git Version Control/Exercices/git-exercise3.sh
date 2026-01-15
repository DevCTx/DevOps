git checkout -b feature/logstash_upgrade

# modif of build.grade to set 
#    implementation 'net.logstash.logback:logstash-logback-encoder:7.3'    
#    testImplementation 'junit:junit:4.12'
# instead of 
#    compile group: 'net.logstash.logback', name: 'logstash-logback-encoder', version: '5.2'
#    testCompile group: 'junit', name: 'junit', version: '4.12'

# test app with 
# ./gradlew bootRun
# and check
# http://localhost:8080/

# modify src/main/webapp/index.html with
# <img src="https://www.careeraddict.com/uploads/article/58721/illustration-group-people-team-meeting.jpg" />

git diff
# should be ok

git add .
git commit -m "modif logstash-logback-encoder 5.2 -> 7.3 + add img in index.html"
git push


