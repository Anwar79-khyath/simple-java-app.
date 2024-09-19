pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('sayyadanwar')  // Jenkins credential ID for Docker Hub
    }
    stages {
        stage('Clone Repository') {
            steps {
                // Cloning the Git repository
                git 'https://github.com/sayyadanawr/simple-java-app.git'
            }
        }
        stage('Build with Maven') {
            steps {
                // Running Maven to build the Java application
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Building the Docker image using the Dockerfile
                    def app = docker.build("sayyadanwar/simple-java-app")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        // Tagging and pushing the Docker image to Docker Hub
                        def app = docker.build("sayyadanwar/simple-java-app")
                        app.push("${env.BUILD_NUMBER}")  // Push the image tagged with build number
                        app.push("latest")  // Push the image with the 'latest' tag
                    }
                }
            }
        }
    }
}
