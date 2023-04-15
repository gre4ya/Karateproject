@tg
Feature: Validate Tech Global backend function

Background: Define URL
    Given url 'https://tech-global-training.com/'
    
Scenario: Create a student
   Given path 'students'
   And request {"firstName":"aq","lastName":"dqd","email":"asdfaaaa@gmail.com","dob":"2001-02-02"}
   When method Post
   Then status 200

Scenario: Create and delete student
    Given path 'students'
    And request {"firstName":"aq","lastName":"dqd","email":"asdf1aa@gmail.com","dob":"2001-02-02"}
    When method Post
    Then status 200
    * def studenId = response.id

    Given path 'students',studenId
    When method Delete
    Then status 200






