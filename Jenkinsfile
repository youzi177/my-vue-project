pipeline {
    agent any

    environment {
        PROJECT_NAME = 'my-vue-project'
    }

    stages {

        stage('拉取代码') {
            steps {
                checkout scm
            }
        }

        stage('构建镜像') {
            steps {
                sh '''
                    docker compose build
                '''
            }
        }

        stage('部署项目') {
            steps {
                sh '''
                    docker compose up -d --remove-orphans
                '''
            }
        }

        stage('清理资源') {
            steps {
                sh '''
                    docker image prune -f
                '''
            }
        }
    }

    post {
        success {
            echo '项目构建和部署成功！'
        }

        failure {
            echo '项目构建或部署失败！'
        }
    }
}