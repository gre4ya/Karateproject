Feature: Hooks

Background: hooks
    # * def result = callonce read('classpath:helpers/Dummy.feature')
    # * def username = result.username

    # after hooks
    * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') } // runs after each scenario
    * configure afterFeature = // runs after each feature (embeaded expression)
    """ 
        function(){
            karate.log('After Feature Text')
        }
    """
Scenario: First scenario
    * print username
    * print 'This is first scenario'

Scenario: First scenario
    * print username
    * print 'This is second scenario'
