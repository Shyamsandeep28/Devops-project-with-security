pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/Shyamsandeep28/Devops-project-with-security.git'
            }
        }

        stage('Trivy Scan - Source Code') {
            steps {
                sh '''
                    echo "🔍 Scanning source code with Trivy..."
                    trivy fs --exit-code 1 --no-progress --severity HIGH,CRITICAL .
                '''
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh '''
                    mvn sonar:sonar \
                        -Dsonar.projectKey=DevopsProject \
                        -Dsonar.host.url=http://13.235.128.61:9000 \
                        -Dsonar.login=sqa_0ec3f1cbd2e95ed0fee316b1c7bd9af63b106108
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Trivy Scan - Docker Image') {
            steps {
                sh '''
                    echo "🔍 Scanning Docker image with Trivy..."
                    # trivy image --exit-code 1 --no-progress --severity HIGH,CRITICAL $IMAGE_NAME
                    trivy image $IMAGE_NAME
                '''
            }
        }

    stage('Run Container as Non-root') {
    steps {
        sh '''
            echo "🚀 Running container as non-root user..."
            docker rm -f myapp_container || true
            docker run -d --name myapp_container -p 8081:8080 $IMAGE_NAME
            sleep 10
            docker logs myapp_container
        '''
    }
}
    }

   }
