pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
    
  }
  stages {
    stage('Build') {
      steps {
        sh 'echo build'
      }
    }
    stage('Prod') {
      steps {
        sh 'echo deployed'
      }
    }
  }
}