pipeline {
    agent { label 'Ubuntu2' }

    environment {
        REMOTE_USER = 'jenkins'
        REMOTE_HOST = '192.168.1.32'
        REMOTE_DIR = '/apps/javaapp'
        START_FILE = 'start.sh'
        STOP_FILE = 'stop.sh'
        JAR_NAME = 'hello-devops-1.0-SNAPSHOT.jar'
    }

    stages {
        stage('Checkout') {
            steps {
                sshagent(['github-ssh']) {
                    git url: 'git@github.com:rajsyamraj/Java_Webapp_Final.git', branch: 'master'
                }
            }
        }

        stage('Copy JAR to Remote VM') {
            steps {
                sh '''
                    scp -o StrictHostKeyChecking=no ${JAR_NAME} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/
                '''
            }
        }

        stage('Copy service file to Remote VM') {
            steps {
                sh '''
                    scp -o StrictHostKeyChecking=no ${START_FILE} ${STOP_FILE} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/
                '''
            }
        }        

        stage('Stop Existing App on Remote VM') {
            steps {
                sh """
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "/bin/sh ${REMOTE_DIR}/${STOP_FILE}"
                """
            }
        }

        stage('Run App on Remote VM') {
            steps {
                sh """
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "/bin/sh ${REMOTE_DIR}/${START_FILE}"                                         
                """
            }
        }
    }
}
