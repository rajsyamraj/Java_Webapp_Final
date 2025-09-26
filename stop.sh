pkill -f hello-devops-1.0-SNAPSHOT.jar || ps -ef | grep ${JAR_NAME} | grep -v grep || echo "App not running"
