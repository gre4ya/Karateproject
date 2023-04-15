@ignore
Feature:
Scenario: Create Token
    Given url 'https://conduit.productionready.io/api/'
    Given path 'users/login'
    And request {"user": {"email": "pikacvhy@gmail.com","password": "12345678"}}
    When method Post
    Then status 200
    * def authToken = response.user.token
