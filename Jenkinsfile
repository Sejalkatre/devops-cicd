pipeline {
    agent any

    environment {
        REGISTRY = "your-registry"          // e.g. dockerhub username or ECR repo
        IMAGE    = "app"
        TAG      = "${env.BUILD_NUMBER}"    // unique tag per build
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sejalkatre/devops-cicd.git'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                sh """
                docker build -t $REGISTRY/$IMAGE:$TAG .
                docker push $REGISTRY/$IMAGE:$TAG
                """
            }
        }

        stage('Update Manifests') {
            steps {
                sh """
                sed -i "s|image:.*|image: $REGISTRY/$IMAGE:$TAG|" k8s/deployment.yaml
                git add k8s/deployment.yaml
                git commit -m "Update image to $REGISTRY/$IMAGE:$TAG"
                git push origin main
                """
            }
        }
    }
}
