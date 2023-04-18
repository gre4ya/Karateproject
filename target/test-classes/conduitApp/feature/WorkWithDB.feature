Feature: work with DB

    Background: connect to db
        * def dbHandler = Java.type('helpers.DbHandler')
    Scenario: Seed database with a new Job
        * eval dbHandler.addNewJobWithName("QA2")

    Scenario: Get level for Job
        * def level = dbHandler.getMinAndMAxLevelsForJob("QA2")    
        * print level.minLvl
        * print level.maxLvl
        And match level.minLvl == '50'
        And match level.maxLvl == '100'

