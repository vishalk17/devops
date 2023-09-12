def emailRecipients = 'vishal.kapadi@ecosmob.com'
// for multiple recipients:  def emailRecipients = 'xyz@ecosmob.com,abc@ecosmob.com'

pipeline {
    agent {
        label 'master'
    }
    environment {
        docker_image_name = 'vishalk17/nginx'
        docker_image_tag = 'v2.0'
        DOCKERHUB_CREDENTIALS = credentials('docker-credential')
        JENKINS_URL = "${env.JENKINS_URL}" // Jenkins URL
        BUILD_URL = "${env.BUILD_URL}" // Build URL
        CONSOLE_URL = "${BUILD_URL}/console" // Console output URL
        JOB_NAME = "${env.JOB_NAME}" // Job Name
        BUILD_NUMBER = "${env.BUILD_NUMBER}" // Build Number
        is_build_needed = 'y' // Set 'y' to build the image, 'n' to skip building
    }

    stages {
        stage('Start Notification') {
            steps {
                script {
                    currentBuild.result = 'SUCCESS' // Set the default result to SUCCESS
                    emailext subject: "Job Started: ${JOB_NAME} #${BUILD_NUMBER}",
                        mimeType: 'text/html', // Set content type to HTML
                        body: """
                        The job has started.<br>
                        <a href='${BUILD_URL}'>Click here</a> to view the job in Jenkins.<br>
                        <a href='${CONSOLE_URL}'>Click here</a> to view the console output.
                        """,
                        to: emailRecipients
                }
            }
        }

        stage('Global Condition') {
            when {
                expression { is_build_needed == 'n' }
            }
            steps {
                script {
                    currentBuild.result = 'SUCCESS'
                    error("Skipping all stages as is_build_needed is 'n'")
                }
            }
        }

        stage('Build image') {
            steps {
                sh 'pwd && whoami'
                sh "docker build -t ${docker_image_name}:${docker_image_tag} ."
            }
        }

        stage('Login to Docker') {
            steps {
                sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
            }
        }

        stage('Push docker image to Docker Hub') {
            steps {
                sh "docker push ${docker_image_name}:${docker_image_tag}"
            }
        }
    }

    post {
        success {
            script {
                currentBuild.result = 'SUCCESS' // Set the build result to SUCCESS
            }
            emailext subject: "Job Succeeded: ${JOB_NAME} #${BUILD_NUMBER}",
                mimeType: 'text/html', // Set content type to HTML
                body: """
                The job has succeeded.<br>
                <a href='${BUILD_URL}'>Click here</a> to view the job in Jenkins.<br>
                <a href='${CONSOLE_URL}'>Click here</a> to view the console output.
                """,
                to: emailRecipients
        }
        failure {
            script {
                currentBuild.result = 'FAILURE' // Set the build result to FAILURE
            }
            emailext subject: "Job Failed: ${JOB_NAME} #${BUILD_NUMBER}",
                mimeType: 'text/html', // Set content type to HTML
                body: """
                The job has failed.<br>
                <a href='${BUILD_URL}'>Click here</a> to view the job in Jenkins.<br>
                <a href='${CONSOLE_URL}'>Click here</a> to view the console output.
                """,
                to: emailRecipients
        }
        always {
            sh 'docker logout'
        }
    }
}
