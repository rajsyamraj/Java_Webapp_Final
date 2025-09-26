pipeline {
    agent { label 'Ubuntu2' }

    environment {
        REMOTE_USER = 'jenkins'
        REMOTE_HOST = '192.168.1.32'
        REMOTE_DIR = '/apps/javaapp'
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
                sh """
                    scp -o StrictHostKeyChecking=no ${JAR_NAME} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/
                """
            }
        }

        stage('Stop Existing App on Remote VM') {
            steps {
                sh """
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                    'pkill -f ${JAR_NAME} || echo "No running app found"'
                """
            }
        }

        stage('Run App on Remote VM') {
            steps {
                sh """
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                    'cd ${REMOTE_DIR} && nohup java -jar ${JAR_NAME} > app.log 2>&1 & disown'
                """
            }
        }

        stage('Verify App Status') {
            steps {
                sh """
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                    'pgrep -f "${JAR_NAME}" && echo "✅ App is running." || (echo "❌ App is NOT running." && exit 1)'
                """
            }
        }
    }
}
