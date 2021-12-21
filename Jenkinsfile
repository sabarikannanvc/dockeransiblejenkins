pipeline {
    agent any
    environment {
         DOCKER_TAG = getVersion()
        
    }
   
    tools {
        maven 'Maven3'
    }
    stages
        {
            stage('copy SCM'){
                steps{
                    git 'https://github.com/sabarikannanvc/dockeransiblejenkins.git'
                }
            }
            stage('MVN Build'){
                steps{
                        sh 'mvn clean package'
                }
                post {
                      always {
                                    jiraSendBuildInfo branch: '', site: 'megabytes.atlassian.net'
                             }
                }
            }
            stage('DOCKER build'){
                steps{
                    sh "docker build . -t myprojects123/sampleapp:${DOCKER_TAG}"
                }
            }
            stage('Docker push dockerhub'){
                steps{
                    withCredentials([string(credentialsId: '2f6c69a5-6ef9-400f-9484-91ef5370eeae', variable: 'MyDockerPwd')]) {
                             sh "docker login -u myprojects123 -p ${MyDockerPwd}"
                    }
                    sh "docker push myprojects123/sampleapp:${DOCKER_TAG}"
                }
            }
            stage('ANSIBLE slave'){
                steps{
                    ansiblePlaybook become: true, credentialsId: 'dev-server', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
                }
            }
           
        }
}
   


def getVersion(){
    def commitHash = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
