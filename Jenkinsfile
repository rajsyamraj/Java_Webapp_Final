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

        stage('Deploy to Remote VM') {
            steps {
                sshagent(['github-ssh']) {
                    sh """
                        scp -o StrictHostKeyChecking=no target/${JAR_NAME} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/

                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                        'pkill -f ${JAR_NAME} || echo "No running app found"'

                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                        'cd ${REMOTE_DIR} && nohup java -jar ${JAR_NAME} > app.log 2>&1 & disown'

                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                        'pgrep -f "${JAR_NAME}" && echo "✅ App is running." || (echo "❌ App is NOT running." && exit 1)'
                    """
                }
            }
        }
    }
}
