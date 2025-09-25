pipeline {
    agent any

    environment {
        JAR_NAME = 'hello-devops-1.0-SNAPSHOT.jar'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-ssh', url: 'git@github.com:rajsyamraj/Java_Webapp_Final.git', branch: 'main'
            }
        }

        stage('Run JAR Locally') {
            steps {
                sh '''
                    chmod +x ${JAR_NAME}
                    nohup java -jar ${JAR_NAME} > app.log 2>&1 &
                    exit 0
                '''
            }
        }
    }
}
