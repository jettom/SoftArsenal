# fakemail
```
git clone https://github.com/Nilhcem/FakeSMTP.git

## build
cd FaceSMTP
mvn package -Dmaven.test.skip

## run
java -jar fakeSMTP-2.1-SNAPSHOT.jar -p 2525 -a 192.168.0.88 -o c:\temp\mail
```

# java mail
```

mvn package
mvn exec:java -Dexec.mainClass="com.example.SendEmail"
--mvn exec:java -Dexec.mainClass="SendEmail"

```