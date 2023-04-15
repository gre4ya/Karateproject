@ignore
Feature: Articles

Background: Define URL
    Given url 'https://api.realworld.io/api/'
    Given path 'users/login'
    And request {"user": {"email": "pikacvhy@gmail.com","password": "12345678"}}
    When method Post
    Then status 200
    * def token = response.user.token
    # * def tokenResponse = call read('classpath:healpers/CreateToken.feature')
    # * def token = tokenResponse.authToken
Scenario: Create a new article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article":{"tagList":["cats"],"title":"article02","description":"this article is about cats","body":"cats are the best"}}
    When method Post
    Then status 200
    And match response.article.title == 'article123456789'
Scenario: Create and delete article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article":{"tagList":["cats"],"title":"article2","description":"this article is about cats","body":"cats are the best"}}
    When method Post
    Then status 200
    * def articleId = response.article.slug

    # Given params {limit: 10, offset: 0}
    # Given path 'articles'
    # When method Get
    # Then status 200
    # And match response.articles[0].title == 'If we quantify the alarm, we can get to the FTP pixel through the online SSL interface!'

    # Given header Authorization = 'Token ' + token
    # Given path 'articles',articleId
    # When method Delete
    # Then status 204


    # Given params {limit: 10, offset: 0}
    # Given path 'articles'
    # When method Get
    # Then status 200
    # And match response.articles[0].title == 'If we quantify the alarm, we can get to the FTP pixel through the online SSL interface!'


