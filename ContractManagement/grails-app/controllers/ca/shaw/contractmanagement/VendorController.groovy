package ca.shaw.contractmanagement

/**
* Copyright (c) 2012 Laurence Brockman
*
* Permission is hereby granted, free of charge, to any person obtaining a copy of this
* software and associated documentation files (the "Software"), to deal in the Software
* without restriction, including without limitation the rights to use, copy, modify,
* merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
* permit persons to whom the Software is furnished to do so, subject to the following
* conditions:
*
* The above copyright notice and this permission notice shall be included in all copies
* or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
* INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
* PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
* FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
* OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
* DEALINGS IN THE SOFTWARE.
*/

import org.springframework.dao.DataIntegrityViolationException

class VendorController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [vendorInstanceList: Vendor.list(params), vendorInstanceTotal: Vendor.count()]
    }

    def create() {
        [vendorInstance: new Vendor(params)]
    }

    def save() {
        def vendorInstance = new Vendor(params)
        if (!vendorInstance.save(flush: true)) {
            render(view: "create", model: [vendorInstance: vendorInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'vendor.label', default: 'Vendor'), vendorInstance.id])
        redirect(action: "show", id: vendorInstance.id)
    }

    def show() {
        def vendorInstance = Vendor.get(params.id)
        if (!vendorInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'vendor.label', default: 'Vendor'), params.id])
            redirect(action: "list")
            return
        }

        [vendorInstance: vendorInstance]
    }

    def edit() {
        def vendorInstance = Vendor.get(params.id)
        if (!vendorInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vendor.label', default: 'Vendor'), params.id])
            redirect(action: "list")
            return
        }

        [vendorInstance: vendorInstance]
    }

    def update() {
        def vendorInstance = Vendor.get(params.id)
        if (!vendorInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vendor.label', default: 'Vendor'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (vendorInstance.version > version) {
                vendorInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'vendor.label', default: 'Vendor')] as Object[],
                          "Another user has updated this Vendor while you were editing")
                render(view: "edit", model: [vendorInstance: vendorInstance])
                return
            }
        }

        vendorInstance.properties = params

        if (!vendorInstance.save(flush: true)) {
            render(view: "edit", model: [vendorInstance: vendorInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'vendor.label', default: 'Vendor'), vendorInstance.id])
        redirect(action: "show", id: vendorInstance.id)
    }

    def delete() {
        def vendorInstance = Vendor.get(params.id)
        if (!vendorInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'vendor.label', default: 'Vendor'), params.id])
            redirect(action: "list")
            return
        }

        try {
            vendorInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'vendor.label', default: 'Vendor'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'vendor.label', default: 'Vendor'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
