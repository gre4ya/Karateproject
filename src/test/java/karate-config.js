function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  // comand to run environment
  // mvn test -Dkarate.options="--tags @debug" -Dkarate.env="qa"
  if (env == 'dev') {
    config.userEmail = 'pikacvhy@gmail.com'
    config.userPassword = '12345678'
  } else if (env == 'qa') {
    config.userEmail = 'pikacvhyQA@gmail.com'
    config.userPassword = '12345678!'
  }

  var accessToken = karate.callSingle('classpath:healpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}