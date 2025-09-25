pipeline {
    agent any

    environment {
        REMOTE_USER = 'jenkins'
        REMOTE_HOST = '192.168.1.31'
        REMOTE_DIR = '/apps/javaapp'
        JAR_NAME = 'hello-devops-1.0-SNAPSHOT.jar'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-ssh', url: 'git@github.com:rajsyamraj/Java_Webapp_Final.git', branch: 'main'
            }
        }

        stage('Copy JAR to Remote VM') {
            steps {
                sh '''
                    scp -o StrictHostKeyChecking=no ${JAR_NAME} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/
                '''
            }
        }

        stage('Run JAR on Remote VM') {
            steps {
                sh '''
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} '
                        cd ${REMOTE_DIR} &&
                        nohup java -jar ${JAR_NAME} > app.log 2>&1 &
                    '
                '''
            }
        }
    }
}
