package ca.shaw.contractmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(ContractController)
@Mock(Contract)
class ContractControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/contract/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.contractInstanceList.size() == 0
        assert model.contractInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.contractInstance != null
    }

    void testSave() {
        controller.save()

        assert model.contractInstance != null
        assert view == '/contract/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/contract/show/1'
        assert controller.flash.message != null
        assert Contract.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/contract/list'


        populateValidParams(params)
        def contract = new Contract(params)

        assert contract.save() != null

        params.id = contract.id

        def model = controller.show()

        assert model.contractInstance == contract
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/contract/list'


        populateValidParams(params)
        def contract = new Contract(params)

        assert contract.save() != null

        params.id = contract.id

        def model = controller.edit()

        assert model.contractInstance == contract
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/contract/list'

        response.reset()


        populateValidParams(params)
        def contract = new Contract(params)

        assert contract.save() != null

        // test invalid parameters in update
        params.id = contract.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/contract/edit"
        assert model.contractInstance != null

        contract.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/contract/show/$contract.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        contract.clearErrors()

        populateValidParams(params)
        params.id = contract.id
        params.version = -1
        controller.update()

        assert view == "/contract/edit"
        assert model.contractInstance != null
        assert model.contractInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/contract/list'

        response.reset()

        populateValidParams(params)
        def contract = new Contract(params)

        assert contract.save() != null
        assert Contract.count() == 1

        params.id = contract.id

        controller.delete()

        assert Contract.count() == 0
        assert Contract.get(contract.id) == null
        assert response.redirectedUrl == '/contract/list'
    }
}
