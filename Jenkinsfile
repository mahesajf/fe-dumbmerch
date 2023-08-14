def branch = "production"
def repo = "git@github.com:mahesajf/fe-dumbmerch.git"
def cred = "jenkins"
def dir = "~/fe-dumbmerch"
def server = "mahesajihanfadhlurrahman@34.142.157.248"
def imagename = "fe-dumbmerch"
def dockerusername = "mahesaj"

pipeline {
    agent any

    stages {
        stage('Repository pull') {
            steps {
                sshagent([cred]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${dir}
                        git remote add origin ${repo} || git remote set-url origin ${repo}
                        git pull origin ${branch}
                        exit
                        EOF
                    """
                }
            }
        }

        stage('Image build') {
            steps {
                sshagent([cred]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${dir}
                        docker build -t ${imagename}:latest .
                        exit
                        EOF
                    """
                }
            }
        }

        stage('Running the image in a container') {
            steps {
                sshagent([cred]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${dir}
                        docker container stop ${imagename} || true
                        docker container rm ${imagename} || true
                        docker run -d -p 3001:3000 --name="${imagename}"  ${imagename}:latest
                        exit
                        EOF
                    """
                }
            }
        }

        stage('Image push') {
            steps {
               sshagent([cred]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        docker tag ${imagename}:latest ${dockerusername}/${imagename}:latest
                        docker image push ${dockerusername}/${imagename}:latest
                        exit
                    EOF
                    """
                }
            }
        }
    }
}
