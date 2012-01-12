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
import grails.plugins.springsecurity.Secured;

class ClauseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [clauseInstanceList: Clause.list(params), clauseInstanceTotal: Clause.count()]
    }

	@Secured(['ROLE_ADMIN'])
    def create() {
        [clauseInstance: new Clause(params)]
    }

	@Secured(['ROLE_ADMIN'])
    def save() {
        def clauseInstance = new Clause(params)
        if (!clauseInstance.save(flush: true)) {
            render(view: "create", model: [clauseInstance: clauseInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'clause.label', default: 'Clause'), clauseInstance.id])
        redirect(action: "show", id: clauseInstance.id)
    }

    def show() {
        def clauseInstance = Clause.get(params.id)
        if (!clauseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'clause.label', default: 'Clause'), params.id])
            redirect(action: "list")
            return
        }

        [clauseInstance: clauseInstance]
    }

	@Secured(['ROLE_ADMIN'])
    def edit() {
        def clauseInstance = Clause.get(params.id)
        if (!clauseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'clause.label', default: 'Clause'), params.id])
            redirect(action: "list")
            return
        }

        [clauseInstance: clauseInstance]
    }

	@Secured(['ROLE_ADMIN'])
    def update() {
        def clauseInstance = Clause.get(params.id)
        if (!clauseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'clause.label', default: 'Clause'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (clauseInstance.version > version) {
                clauseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'clause.label', default: 'Clause')] as Object[],
                          "Another user has updated this Clause while you were editing")
                render(view: "edit", model: [clauseInstance: clauseInstance])
                return
            }
        }

        clauseInstance.properties = params

        if (!clauseInstance.save(flush: true)) {
            render(view: "edit", model: [clauseInstance: clauseInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'clause.label', default: 'Clause'), clauseInstance.id])
        redirect(action: "show", id: clauseInstance.id)
    }

	@Secured(['ROLE_ADMIN'])
    def delete() {
        def clauseInstance = Clause.get(params.id)
        if (!clauseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'clause.label', default: 'Clause'), params.id])
            redirect(action: "list")
            return
        }

        try {
            clauseInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'clause.label', default: 'Clause'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'clause.label', default: 'Clause'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
