node {

  // This limits build concurrency to 1 per branch
  properties([disableConcurrentBuilds()])

  try {
    checkout scm

    env.F8_TAG = [env.BRANCH_NAME, env.BUILD_ID, sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()].join('-')
    env.F8_ENVIRONMENT = env.BRANCH_NAME
    env.F8_ENV_TYPE = 'dev'
    env.F8_LOG_LINKS = 'true'

    stage('Build') {
      //docker.withRegistry('https://gcr.io', 'gcr') {
      docker.withRegistry('', 'reg-creds') {
        sh 'f8 build --push'
      }
    }
    stage('Deploy') {
      sh 'f8 deploy'
    }
    stage('Test') {
      sh 'f8 test'
    }
  }
  catch (Exception err) {
    currentBuild.result = 'FAILURE'
  }
  finally {
    if (currentBuild.result != 'SUCCESS'){
      slackSend(color: '#FF0000', message: "${JOB_NAME} <${BUILD_URL}/display/redirect|Build #${BUILD_NUMBER}> " + currentBuild.result)
    }
  }
}
