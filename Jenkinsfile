pipeline {
    agent any

    environment {
        REMOTE_USER = 'jenkins'
        REMOTE_HOST = '192.168.1.32'
        REMOTE_DIR = '/apps/javaapp'
        JAR_NAME = 'hello-devops-1.0-SNAPSHOT.jar' // Replace with actual jar name
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/rajsyamraj/-apps-Java_Webapp_Final.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Copy JAR to Remote VM') {
            steps {
                sh '''
                    scp -o StrictHostKeyChecking=no target/${JAR_NAME} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/
                '''
            }
        }

        stage('Run App on Remote VM') {
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
