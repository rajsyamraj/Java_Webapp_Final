pipeline {
    agent { label 'Ubuntu2' }

    environment {
        REMOTE_USER = 'jenkins'
        REMOTE_HOST = '192.168.1.32'
        REMOTE_DIR  = '/apps/javaapp'
        JAR_NAME    = 'hello-devops-1.0-SNAPSHOT.jar'
    }

    stages {
        stage('Checkout') {
            steps {
                sshagent(['github-ssh']) {
                    git url: 'git@github.com:rajsyamraj/Java_Webapp_Final.git', branch: 'master'
                }
            }
        }

        // Optional: Uncomment if you want to build the jar using Maven
        // stage('Build') {
        //     steps {
        //         sh 'mvn clean package'
        //     }
        // }

        stage('Deploy and Run on Remote VM') {
            steps {
                sshagent(['jenkins']) {
                    sh """
                        # Copy JAR from repo root
                        scp -o StrictHostKeyChecking=no ${JAR_NAME} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/

                        # Stop existing app
                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                        'pkill -f ${JAR_NAME} || echo "No running app found"'

                        # Start new app
                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                        'cd ${REMOTE_DIR} && nohup java -jar ${JAR_NAME} > app.log 2>&1 & disown'

                        # Verify app status
                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} \\
                        'pgrep -f "${JAR_NAME}" && echo "✅ App is running." || (echo "❌ App is NOT running." && exit 1)'
                    """
                }
            }
        }
    }
}
