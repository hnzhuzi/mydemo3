pipeline {
    // agent any
    // agent { label 'master' }
    agent {
        kubernetes {
        label 'jnlp'
        yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: jnlp
    image: 'harbor.k8s.maimaiti.site/library/jnlp-slave:3.27-1-myv3'
    args: ['\$(JENKINS_SECRET)', '\$(JENKINS_NAME)']
    volumeMounts:
    - name: "volume-0"
      mountPath: "/app"
    - name: "volume-1"
      mountPath: "/var/run/docker.sock"
  volumes:
  - name: "volume-0"
    persistentVolumeClaim:
      claimName: "jnlp"
  - name: "volume-1"
    hostPath:
      path: "/var/run/docker.sock"
        """
        }
    }

/*     tools {
        jdk "jdk8"
    }
    options {
        timestamps()
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10'))
        skipDefaultCheckout(true)
    }
 */ 
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
                // script {
                //     BuildTag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                // }
            }
        }

        stage('Pre Deploy'){
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
        } 
      
        stage('Deploy springboot') {
            when {
                expression { return "$params.Module".contains('springboot')}
            }
            steps {
                sh '''
                    cd springboot/
                    mvn -Dmaven.test.skip=true clean package
                    imageName=harbor.k8s.maimaiti.site/library/jenkins-demo-springboot:${BuildTag}
                    docker build -t $imageName .
                    docker push $imageName
                    docker rmi $imageName
                    sed -i "s/<BUILD_TAG>/${BuildTag}/" k8s.yaml
                    kubectl --kubeconfig=/app/.kube/config -n kube-system apply -f k8s.yaml --record
                    kubectl --kubeconfig=/app/.kube/config -n kube-system rollout status deployment jenkins-demo-springboot
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
                    mvn -Dmaven.test.skip=true clean package
                    imageName=harbor.k8s.maimaiti.site/library/jenkins-demo-tomcat:${BuildTag}
                    docker build -t $imageName .
                    docker push $imageName
                    docker rmi $imageName
                    sed -i "s/<BUILD_TAG>/${BuildTag}/" k8s.yaml
                    kubectl --kubeconfig=/app/.kube/config -n kube-system apply -f k8s.yaml --record
                    kubectl --kubeconfig=/app/.kube/config -n kube-system rollout status deployment jenkins-demo-tomcat
                '''
            }
        }
        stage('Deploy vue') {
            when {
                expression { return "$params.Module".contains('vue')}
            }
            steps {
                    // source /etc/profile
                sh '''
                    cd vue/
                    alias cnpm="npm --registry=https://registry.npm.taobao.org --cache=/app/.npm/.cache/cnpm --disturl=https://npm.taobao.org/dist --userconfig=/app/.cnpmrc"
                    cnpm install; cnpm run build; tar zcf dist.tar.gz -C dist/ .
                    imageName=harbor.k8s.maimaiti.site/library/jenkins-demo-vue:${BuildTag}
                    docker build -t $imageName .
                    docker push $imageName
                    docker rmi $imageName
                    sed -i "s/<BUILD_TAG>/${BuildTag}/" k8s.yaml
                    kubectl --kubeconfig=/app/.kube/config -n kube-system apply -f k8s.yaml --record
                    kubectl --kubeconfig=/app/.kube/config -n kube-system rollout status deployment jenkins-demo-vue
                '''
            }
        }
        stage('Deploy test') {
            when {
                expression { return "$params.Module".contains('test')}
            }
            steps {
                dir('test') {
                    // echo ${InputMap["ENV"]}
                        // echo ${InputMap.ENV}
                    sh """
                        echo ${BuildTag}
                    """
                }

                // container('maven') {
                // sh 'mvn -version'
                // }
                
            }
        }
    }
}


