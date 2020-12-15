pipeline {
    agent any
    tools {
        maven 'apache-maven-3.6.3'
    }
    stages {
        stage('Checkout') {
            steps {
                echo '从GitHub下载项目源码'
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '95298547-6abb-4085-9bdb-ef41a30bd686', url: 'https://github.com/shudelin111/xxl_job.git']]])
            }
        }
        stage('Build') {
            steps {
                echo '开始编译构建'
                sh 'mvn clean compile -U -DskipTests'
            }
        }
        stage('Push') {
            steps {
                sh 'sh start-jenkins.sh'
            }
        }
        stage('Clean') {
            steps {
                echo '清理Maven工程'
                sh 'mvn clean'
            }
        }
    }
}