package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

import conduitApp.performance.createTokens.CreateTokens

class PerfTest extends Simulation {

    CreateTokens.createAccessTokens()

  val protocol = karateProtocol(
    "/api/articles/{articleId}" -> Nil // in scala Nil == null
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  /*
    https://gatling.io/docs/gatling/reference/current/core/session/feeder/#csv-feeders

    // default behavior: use an Iterator on the underlying sequence
    csv("foo").queue();
    
    // randomly pick an entry in the sequence
    sv("foo").random();
    
    // shuffle entries, then behave like queue
    csv("foo").shuffle();
    
    // go back to the top of the sequence once the end is reached
    csv("foo").circular();
  */

  val csvFeeder = csv("articles.csv").circular

  val tokenFeeder = Iterator.continually(Map("token" -> CreateTokens.getNextToken))

  val createArticle = scenario("Create and delete article")
        .feed(csvFeeder)
        .feed(tokenFeeder)
        .exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))


  setUp(
    createArticle.inject(
        atOnceUsers(1),
        nothingFor(4 seconds),
        constantUsersPerSec(1) during (10 seconds),
        constantUsersPerSec(2) during (10 seconds),
        rampUsersPerSec(2) to 10 during (20 seconds),
        nothingFor(5 seconds),
        constantUsersPerSec(1) during (5 seconds),
        ).protocols(protocol)
  ) 

 /*

        https://gatling.io/docs/current/general/simulation_setup/

        setUp(
        scn.injectOpen(
            nothingFor(4), // 1
            atOnceUsers(10), // 2
            rampUsers(10).during(5), // 3
            constantUsersPerSec(20).during(15), // 4
            constantUsersPerSec(20).during(15).randomized(), // 5
            rampUsersPerSec(10).to(20).during(10), // 6
            rampUsersPerSec(10).to(20).during(10).randomized(), // 7
            stressPeakUsers(1000).during(20) // 8
        ).protocols(httpProtocol)
        );
 */

  // to run gatling performance test use command -> $ mvn clean test-compile gatling:test
}