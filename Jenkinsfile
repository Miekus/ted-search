pipeline{
    // triggers {
    //     cron('*/15 * * * *') no need to work with it  only for task purpose 
    // }
    agent any
        options {
        gitLabConnection("jenkinsv2") 
    }
    stages {
        stage('get_commit_msg') {
            steps {
                script {
                    sh 'echo GET COMIT MSG'
                    env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B ${GIT_COMMIT}', returnStdout: true).trim()
                }
            }
        }   
        stage ("MavenCompile"){
            steps{
                script{
                    sh 'echo MAVEN COMPILE STAGE'
                    configFileProvider([configFile(fileId: 'maven-user-stg', variable: 'MAVEN_SETTINGS_XML')]) {
                    sh "mvn -f app/pom.xml --settings $MAVEN_SETTINGS_XML compile " 
                    } 
                }
            }
        }

        stage ("MavenTests"){
            steps{
                script{
                    sh 'echo MAVEN TEST STAGE'
                    configFileProvider([configFile(fileId: 'maven-user-stg', variable: 'MAVEN_SETTINGS_XML')]) {
                    sh "mvn -f app/pom.xml --settings $MAVEN_SETTINGS_XML test"
                    }
                }   
            }
        }

        stage ("MavenPackage"){
            steps{
                script{
                    sh 'echo MAVEN PACKAGE STAGE'
                    configFileProvider([configFile(fileId: 'maven-user-stg', variable: 'MAVEN_SETTINGS_XML')]) {
                    sh "mvn -f app/pom.xml --settings $MAVEN_SETTINGS_XML package"
                    } 
                }
            }
        }
        stage ("DockerBuild"){
            steps{
                script{
                    sh 'echo Docker Build STAGE'
                    sh 'docker build -t mateusz-kiszka-ted-search:latest app/.'
                    sh 'docker build -t mateusz-kiszka-nginx:latest nginx/. '
                }
            }
        }

        stage ("DEPLOY")
        {
            steps
            {
                sh 'echo DEPLOY STAGE'
                sh 'aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.eu-central-1.amazonaws.com'

                sh 'docker tag mateusz-kiszka-ted-search:latest 644435390668.dkr.ecr.eu-central-1.amazonaws.com/mateusz-kiszka-ted-search:latest'
                sh 'docker push 644435390668.dkr.ecr.eu-central-1.amazonaws.com/mateusz-kiszka-ted-search:latest'
                sh 'docker tag mateusz-kiszka-nginx:latest 644435390668.dkr.ecr.eu-central-1.amazonaws.com/mateusz-kiszka-nginx:latest'
                sh 'docker push 644435390668.dkr.ecr.eu-central-1.amazonaws.com/mateusz-kiszka-nginx:latest'
                sh 'sleep 30'
                sh 'docker rmi 644435390668.dkr.ecr.eu-central-1.amazonaws.com/mateusz-kiszka-ted-search:latest'
                sh 'docker rmi 644435390668.dkr.ecr.eu-central-1.amazonaws.com/mateusz-kiszka-nginx:latest'
            }
        }

        stage ("E2E test"){
            when { 
            expression{env.GIT_COMMIT_MSG =~ /(.*)#test(.*)/} 
            }   
            steps{
                script
                {   
                    sh 'echo E2E TESTS STAGE'
                    sh 'terraform -chdir=terraform workspace select dev'
                    sh 'terraform -chdir=terraform destroy -auto-approve -var-file=dev.tfvars'
                    sh 'terraform -chdir=terraform init -var-file=dev.tfvars'
                    sh 'terraform -chdir=terraform plan -out plan.txt -var-file=dev.tfvars'
                    sh 'terraform -chdir=terraform apply -auto-approve -var-file=dev.tfvars'

                    dir('environment') {
                        script {
                            DYNAMIC_IP = sh(
                            script: "terraform output -raw public-ip",
                            returnStdout: true,
                            )
                        }
                    }
                    sh 'sleep 30'
                    sh "curl http://${DYNAMIC_IP}/"
                }
            } 
        } 

        stage("RELEASE")
        {
            when {branch 'main'}
            steps
            {
                script{
                    sh 'echo RELEASE STAGE'
                    sh 'terraform -chdir=terraform workspace select prod'
                    sh 'terraform -chdir=terraform destroy -auto-approve -var-file=prod.tfvars'
                    sh 'terraform -chdir=terraform init -var-file=prod.tfvars'
                    sh 'terraform -chdir=terraform plan -out plan.txt -var-file=prod.tfvars'
                    sh 'terraform -chdir=terraform apply -auto-approve -var-file=prod.tfvars'

                }
            }
        }


    }
    post {
        always {
            emailext body: 'A Test EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
        }
    }
}
