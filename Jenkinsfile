pipeline {
    agent any

    environment {
        REGISTRY = "docker.io/sejalkatre"   // Docker Hub namespace
        IMAGE    = "devops-cicd"            // Your repo name
        TAG      = "${env.BUILD_NUMBER}"    // Unique tag per build
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sejalkatre/devops-cicd.git'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker build -t $REGISTRY/$IMAGE:$TAG .
                    docker push $REGISTRY/$IMAGE:$TAG
                    """
                }
            }
        }

        stage('Update Manifests') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-creds', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                    sh """
                    sed -i "s|image:.*|image: $REGISTRY/$IMAGE:$TAG|" k8s/deployment.yaml
                    git config user.email "ci-bot@example.com"
                    git config user.name "ci-bot"
                    git add k8s/deployment.yaml
                    git commit -m "Update image to $REGISTRY/$IMAGE:$TAG" || echo "No changes to commit"
                    git push https://$GIT_USER:$GIT_PASS@github.com/sejalkatre/devops-cicd.git main
                    """
                }
            }
        }
    }
}
