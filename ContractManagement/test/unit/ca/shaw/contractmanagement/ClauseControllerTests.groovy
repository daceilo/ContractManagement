package ca.shaw.contractmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(ClauseController)
@Mock(Clause)
class ClauseControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/clause/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.clauseInstanceList.size() == 0
        assert model.clauseInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.clauseInstance != null
    }

    void testSave() {
        controller.save()

        assert model.clauseInstance != null
        assert view == '/clause/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/clause/show/1'
        assert controller.flash.message != null
        assert Clause.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/clause/list'


        populateValidParams(params)
        def clause = new Clause(params)

        assert clause.save() != null

        params.id = clause.id

        def model = controller.show()

        assert model.clauseInstance == clause
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/clause/list'


        populateValidParams(params)
        def clause = new Clause(params)

        assert clause.save() != null

        params.id = clause.id

        def model = controller.edit()

        assert model.clauseInstance == clause
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/clause/list'

        response.reset()


        populateValidParams(params)
        def clause = new Clause(params)

        assert clause.save() != null

        // test invalid parameters in update
        params.id = clause.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/clause/edit"
        assert model.clauseInstance != null

        clause.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/clause/show/$clause.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        clause.clearErrors()

        populateValidParams(params)
        params.id = clause.id
        params.version = -1
        controller.update()

        assert view == "/clause/edit"
        assert model.clauseInstance != null
        assert model.clauseInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/clause/list'

        response.reset()

        populateValidParams(params)
        def clause = new Clause(params)

        assert clause.save() != null
        assert Clause.count() == 1

        params.id = clause.id

        controller.delete()

        assert Clause.count() == 0
        assert Clause.get(clause.id) == null
        assert response.redirectedUrl == '/clause/list'
    }
}
