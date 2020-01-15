pipeline {
    agent any
    // agent { label 'master' }
    tools {
        jdk "jdk8"
    }
    options {
        timestamps()
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10'))
        /* skipDefaultCheckout(true) */
    }
    parameters {
        extendedChoice(
        name: 'Module',
        description: '模块',
        type: 'PT_CHECKBOX',
        visibleItemCount: 4,
        multiSelectDelimiter: ',',
        quoteValue: false,
        value:'springboot,tomcat,vue,test',
        defaultValue: '',
        saveJSONParameterToFile: false
        )
        string(name: 'Branch', description: '分支', defaultValue: 'master')
    }
    environment {
        BuildTag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
    }

    stages {
        stage('Get Code') {
            steps {
                git branch: "$Branch",  credentialsId: 'gitlab', url: 'http://gitlab.k8s.maimaiti.site/root/jenkins-demo.git'
                withCredentials([usernamePassword(credentialsId: 'harbor', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${dockerHubUser} -p ${dockerHubPassword} harbor.k8s.maimaiti.site"
                }
            }
        }
/*         stage('Pre Deploy'){
            steps{
                script{
                    InputMap = input (
                        message: '准备发布到哪个环境？',
                        ok: '确定',
                        parameters:[
                            choice(name: 'ENV', choices: 'dev\nsit\nuat\nprd\ndefault', description: '发布到什么环境？'),
                            string(name: 'myparam', defaultValue: '', description: '')
                        ],
                        submitter: 'admin',
                        submitterParameter: 'APPROVER'
                    )
                }
            }
        } */
        stage('Deploy springboot') {
            when {
                expression { return "$params.Module".contains('springboot')}
            }
            steps {
                //sh "kubectl --kubeconfig=/root/.kube/config -n ${InputMap['ENV']} apply -f k8s.yaml --record"
                sh '''
                    cd springboot/
                    /usr/local/apache-maven-3.6.1/bin/mvn -Dmaven.test.skip=true clean package
                    imageName=harbor.k8s.maimaiti.site/library/jenkins-demo-springboot:${BuildTag}
                    docker build -t $imageName .
                    docker push $imageName
                    docker rmi $imageName
                    sed -i "s/<BUILD_TAG>/${BuildTag}/" k8s.yaml
                    kubectl --kubeconfig=/root/.kube/config -n kube-system apply -f k8s.yaml --record
                '''
            }
        }
        stage('Deploy tomcat') {
            when {
                expression { return "$params.Module".contains('tomcat')}
            }
            steps {
                sh '''
                    cd tomcat/
                    /usr/local/apache-maven-3.6.1/bin/mvn -Dmaven.test.skip=true clean package
                    imageName=harbor.k8s.maimaiti.site/library/jenkins-demo-tomcat:${BuildTag}
                    docker build -t $imageName .
                    docker push $imageName
                    docker rmi $imageName
                    sed -i "s/<BUILD_TAG>/${BuildTag}/" k8s.yaml
                    kubectl --kubeconfig=/root/.kube/config -n kube-system apply -f k8s.yaml --record
                '''
            }
        }
        stage('Deploy vue') {
            when {
                expression { return "$params.Module".contains('vue')}
            }
            steps {
                sh '''
                    source /etc/profile
                    cd vue/
                    cnpm install; cnpm run build; cd dist; zip -r dist.zip ./; cd ../
                    imageName=harbor.k8s.maimaiti.site/library/jenkins-demo-vue:${BuildTag}
                    docker build -t $imageName .
                    docker push $imageName
                    docker rmi $imageName
                    sed -i "s/<BUILD_TAG>/${BuildTag}/" k8s.yaml
                    kubectl --kubeconfig=/root/.kube/config -n kube-system apply -f k8s.yaml --record
                '''
            }
        }
        stage('Deploy test') {
            when {
                expression { return "$params.Module".contains('test')}
            }
            steps {
                dir('test') {
                    sh '''
                        cd test1; cd $WORKSPACE/
                        pwd
                    '''
                       
                }
            }
        }
    }
}


