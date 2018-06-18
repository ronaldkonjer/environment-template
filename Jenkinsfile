pipeline {
  agent {
    label "jenkins-jx-base"
  }

  
  stages {
    stage('Validate Environment') {
      steps {
        container('jx-base') {
          sh 'make build'
        }
      }
    }
    stage('Update Environment') {
      when {
        branch 'master'
      }
      steps {
        container('jx-base') {
          sh 'make install'
        }
      }
    }
  }
}
