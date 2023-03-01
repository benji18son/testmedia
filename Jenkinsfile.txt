pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'my-app'
        DOCKER_IMAGE_TAG = 'latest'
        GCR_PROJECT_ID = 'my-project'
        GCR_REGISTRY = 'gcr.io'
        HELM_CHART_NAME = 'my-chart'
        KUBECONFIG = credentials('kubeconfig')
    }
    stages {
        stage('Build Docker image') {
            steps {
                script {
                    def dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                    docker.withRegistry("${GCR_REGISTRY}", 'gcr') {
                        dockerImage.push("${GCR_REGISTRY}/${GCR_PROJECT_ID}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                    }
                }
            }
        }
        stage('Deploy Helm chart') {
            steps {
                script {
                    sh "helm upgrade --install ${HELM_CHART_NAME} ./path/to/helm/chart --namespace my-namespace --kubeconfig ${KUBECONFIG}"
                }
            }
        }
    }
}
