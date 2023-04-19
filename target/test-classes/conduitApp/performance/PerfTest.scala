package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol()

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val createArticle = scenario("Create and delete article").exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))


  setUp(
    createArticle.inject(
        //rampUsers(10) during (5 seconds)
        atOnceUsers(1)
        ).protocols(protocol)

  )
  // to run gatling performance test use command -> $ mvn clean test-compile gatling:test
}