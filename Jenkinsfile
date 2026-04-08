pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sejalkatre/devops-cicd.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t your-registry/app: .'
                sh 'docker push your-registry/app:'
            }
        }
        stage('Update Manifests') {
            steps {
                sh '''
                sed -i "s|image:.*|image: your-registry/app:|" k8s/deployment.yaml
                git add k8s/deployment.yaml
                git commit -m "Update image to "
                git push origin main
                '''
            }
        }
    }
}
