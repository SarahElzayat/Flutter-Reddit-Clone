pipeline {
  agent any
  triggers {
    githubPush()
  }

  	environment {
		DOCKERHUB_CREDENTIALS=credentials('Dockerhub')
	}

  stages{

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

    stage('Build') {

			steps {
				sh 'cd ./reddit'
				sh 'ls'
				sh 'docker build -t waer/flutterweb:latest .'
			}
		}

    stage('Push') {
			steps {
				sh 'docker push waer/flutterweb:latest'
			}
		}

}

	post {
		always {
			sh 'docker logout'
		}
	}

}
