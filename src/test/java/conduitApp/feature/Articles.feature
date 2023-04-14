Feature: Articles

Background: Define URL
    Given url 'https://conduit.productionready.io/api/'

Scenario: Create a new article
    Given path 'users/login'
    And request {"user": {"email": "pikacvhy@gmail.com","password": "12345678"}}
    When method Post
    Then status 200
    * def token = response.user.token

    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article":{"tagList":["cats"],"title":"article","description":"this article is about cats","body":"cats are the best"}}
    When method Post
    Then status 200
