Feature: Sign Up new user

Background: Preconditions
    Given url apiUrl

Scenario: New user Sign Up
    Given def userData = {"email":"pikacvhy_new@gmail.com","username":"pica"}

    Given path 'users'
   #And request {"user":{"email": #(userData.email),"password":"123456789","username": #(userData.username)}}
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
