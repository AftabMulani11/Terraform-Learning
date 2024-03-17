pipeline {
    parameters{
        booleanParam(defaultValue: true, description: 'Should we approve the deployment?', name: 'autoApprove')
    }
    environment{
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    agent any
    stages{
        stage('Plan the infrastructure'){
            steps{
                cmd 'pwd;cd terraform/ ;terraform init'
                cmd "pwd;cd terraform/ ;terraform plan -out tfplan"
                cmd 'pwd;cd terraform/ ;terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval of Plan'){
            when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }
            steps{
                script {
                    def plan = readFile 'terraform/terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
            }
        }
        stage('Apply the infrastructure'){
            steps{
                cmd 'pwd;cd terraform/ ;cd terraform/ ; terraform apply -auto-approve tfplan'
            }
        }
    }
}
