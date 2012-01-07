package ca.shaw.contractmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(VendorController)
@Mock(Vendor)
class VendorControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/vendor/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.vendorInstanceList.size() == 0
        assert model.vendorInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.vendorInstance != null
    }

    void testSave() {
        controller.save()

        assert model.vendorInstance != null
        assert view == '/vendor/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/vendor/show/1'
        assert controller.flash.message != null
        assert Vendor.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/vendor/list'


        populateValidParams(params)
        def vendor = new Vendor(params)

        assert vendor.save() != null

        params.id = vendor.id

        def model = controller.show()

        assert model.vendorInstance == vendor
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/vendor/list'


        populateValidParams(params)
        def vendor = new Vendor(params)

        assert vendor.save() != null

        params.id = vendor.id

        def model = controller.edit()

        assert model.vendorInstance == vendor
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/vendor/list'

        response.reset()


        populateValidParams(params)
        def vendor = new Vendor(params)

        assert vendor.save() != null

        // test invalid parameters in update
        params.id = vendor.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/vendor/edit"
        assert model.vendorInstance != null

        vendor.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/vendor/show/$vendor.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        vendor.clearErrors()

        populateValidParams(params)
        params.id = vendor.id
        params.version = -1
        controller.update()

        assert view == "/vendor/edit"
        assert model.vendorInstance != null
        assert model.vendorInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/vendor/list'

        response.reset()

        populateValidParams(params)
        def vendor = new Vendor(params)

        assert vendor.save() != null
        assert Vendor.count() == 1

        params.id = vendor.id

        controller.delete()

        assert Vendor.count() == 0
        assert Vendor.get(vendor.id) == null
        assert response.redirectedUrl == '/vendor/list'
    }
}
