@ignore
Feature: Articles

Background: Define URL
    * url 'https://api.realworld.io/api/'

    # Given path 'users/login'
    # And request {"user": {"email": "pikacvhy@gmail.com","password": "12345678"}}
    # When method Post
    # Then status 200
    # * def token = response.user.token

    # in karate-config.js line 20, 21 to eliminate line 13, 14 in this file
    # * def tokenResponse = callonce read('classpath:healpers/CreateToken.feature')
    # * def token = tokenResponse.authToken

    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

Scenario: Create a new article
    #Given header Authorization = 'Token ' + token (karate-config.js line 21)
    Given path 'articles'
    # And request {"article":{"tagList":["cats"],"title":"article02","description":"this article is about cats","body":"cats are the best"}}
    And request articleRequestBody
    When method Post
    Then status 200
    And match response.article.title == articleRequestBody.article.title
Scenario: Create and delete article
    #Given header Authorization = 'Token ' + token (karate-config.js line 21)
    Given path 'articles'
    # And request {"article":{"tagList":["cats"],"title":"article2","description":"this article is about cats","body":"cats are the best"}}
    And request articleRequestBody
    When method Post
    Then status 200
    * def articleId = response.article.slug

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == 'If we quantify the alarm, we can get to the FTP pixel through the online SSL interface!'

    #Given header Authorization = 'Token ' + token (karate-config.js line 21)
    Given path 'articles',articleId
    When method Delete
    Then status 204

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == 'If we quantify the alarm, we can get to the FTP pixel through the online SSL interface!'


