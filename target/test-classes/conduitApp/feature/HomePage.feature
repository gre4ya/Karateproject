@smoke
Feature: Test for the home page

Background: Define URL
    Given url apiUrl
 
Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['welcome','introduction'] 
    And match response.tags !contains 'Hitler'
    And match response.tags contains any ['ipsum','aaa','BLM'] // serches for at least one match
    #And match response.tags contains only ['','','']
    And match response.tags == "#array"
    And match each response.tags == "#string"
Scenario: Get 10 articles from the page
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == "#[10]"
    And match response.articlesCount == 197
    And match response.articlesCount != 500
    And match response == {"articles": "#array", "articlesCount": 197}
    And match response.articles[0].createdAt contains '2020'
    And match response.articles[*].favoriteCount contains 1
    And match response.articles[*].authors.bio contains null
#   And match response..bio contains null == match response.articles[*].authors.bio contains null
    And match each response..following == false        


