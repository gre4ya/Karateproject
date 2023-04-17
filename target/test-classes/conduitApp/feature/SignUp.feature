Feature: Sign Up new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    Given url apiUrl

Scenario: New user Sign Up
    # Given def userData = {"email":"pikacvhy_new@gmail.com","username":"pica"} (removed due to random data generator)

    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername() 

    Given path 'users'

    # And request {"user":{"email": #(userData.email),"password":"123456789","username": #(userData.username)}}

    And request
    """
       {
         "user": {
             "email": "pikacvhy@gmail.com",
             "password": "12345678",
             "username": "pica"
          }
       }
    """
    When method Post
    Then status 200    
    And match response ==
    """
        {
            "user":{
                "id": "#number",
                "email": #(randomEmail),
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "username": #(randomUsername),
                "bio": null,
                "image": null,
                "token": "#string"
            }
        }
    """
