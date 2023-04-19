
Feature: Articles

Background: Define URL
    * url 'https://api.realworld.io/api/'
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    # * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestBody.article.title = __gatling.Title
    # * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleRequestBody.article.description = __gatling.Description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

Scenario: Create and delete article
    * configure headers = {"Authorization": #('Token ' + __gatling.token)}
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 200
    * def articleId = response.article.slug

    * karate.pause(5000)

    Given path 'articles',articleId
    When method Delete
    Then status 204
