Script grovy
**************************************************************************************************
*********************************************************************************************
node{
 stage("Pull Source Code From GITHUB"){
 git 'https://github.com/parneet13/cloudknowledge.git'
 }
 stage ("build docker file"){
 sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
 sh 'docker image tag $JOB_NAME:v1.$BUILD_ID parneet13/$JOB_NAME:v1.$BUILD_ID'
 sh 'docker image tag $JOB_NAME:v1.$BUILD_ID parneet13/$JOB_NAME:latest'
 }
 stage ("dockerhub push image"){
 withCredentials([string(credentialsId: 'dockerhubpassword', variable:
'dockerhubpassword')]) {
// some block
 sh 'docker login -u parneet13 -p ${dockerhubpassword}'
 sh 'docker image push parneet13/$JOB_NAME:v1.$BUILD_ID'
 sh 'docker image push parneet13/$JOB_NAME:latest'
 sh 'docker image rmi $JOB_NAME:v1.$BUILD_ID parneet13/$JOB_NAME:v1.$BUILD_ID
parneet13/$JOB_NAME:latest'
}
}
 stage ("deployement on docker container"){
 def dockerrun = 'docker container run -p 8000:80 -d --name cloudknowledges
parneet13/scripted-pipeline-demo:latest'
 def dockerrm = 'docker container rm -f cloudknowledges'
 def docekrimagerm = 'docker image rmi -f parneet13/scripted-pipeline-demo'
 sshagent(['dockerhostpassword']) {
 // some block
 sh "ssh -o StrictHostkeyChecking=no ec2-user@172.31.86.146 ${dockerrm}"
 sh "ssh -o StrictHostkeyChecking=no ec2-user@172.31.86.146 ${docekrimagerm}"
 sh "ssh -o StrictHostkeyChecking=no ec2-user@172.31.86.146 ${dockerrun}"
}
}
}
*************************************************************************************************
******************************************************************************************************
