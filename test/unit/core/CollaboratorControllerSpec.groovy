package core

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(CollaboratorController)
@Mock([Collaborator, Collect])
class CollaboratorControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }


}
