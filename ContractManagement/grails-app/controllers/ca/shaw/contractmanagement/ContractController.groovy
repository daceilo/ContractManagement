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
import org.docx4j.openpackaging.contenttype.ContentType
import org.docx4j.openpackaging.packages.WordprocessingMLPackage
import org.docx4j.openpackaging.parts.PartName
import org.docx4j.openpackaging.parts.WordprocessingML.AlternativeFormatInputPart
import org.docx4j.relationships.Relationship
import org.docx4j.wml.CTAltChunk
import org.docx4j.jaxb.Context;

class ContractController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [contractInstanceList: Contract.list(params), contractInstanceTotal: Contract.count()]
    }

    def create() {
        [contractInstance: new Contract(params)]
    }

    def save() {
        def contractInstance = new Contract(params)
        if (!contractInstance.save(flush: true)) {
            render(view: "create", model: [contractInstance: contractInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [
                message(code: 'contract.label', default: 'Contract'),
                contractInstance.id
        ])
        redirect(action: "show", id: contractInstance.id)
    }

    def show() {
        def contractInstance = Contract.get(params.id)
        if (!contractInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'contract.label', default: 'Contract'),
                    params.id
            ])
            redirect(action: "list")
            return
        }

        [contractInstance: contractInstance]
    }

    def pdf() {
        def contractInstance = Contract.get(params.id)
        if (!contractInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'contract.label', default: 'Contract'),
                    params.id
            ])
            redirect(action: "list")
            return
        }
        renderPdf(template: "/contract/pdf", model: [contractInstance: contractInstance], filename: contractInstance.description)
    }


    //TODO pull all the word manipulation stuff into a service

    // Will return the ID of the part added, this is important to properly add the association
    // Why we do the below is out of scope of comments. Please see more info on www.docx4java.org
    def addToWord = { partName, stringToAdd, mainPart ->
        // Have to make sure the string starts and ends properly
        stringToAdd = stringToAdd.trim();
        if (!stringToAdd.startsWith("<html>")) {
            stringToAdd = "<html>" + stringToAdd
        }
        if (!stringToAdd.endsWith("</html>")) {
            stringToAdd = stringToAdd + "</html>"
        }

        // See other sources for why we do this, beyond the scope of a comment.
        AlternativeFormatInputPart afiPart = new AlternativeFormatInputPart(new PartName(partName));
        afiPart.setContentType(new ContentType("text/html"));
        afiPart.setBinaryData(stringToAdd.getBytes());
        Relationship altChunkRel = mainPart.addTargetPart(afiPart);
        // .. the bit in document body
        CTAltChunk ac = Context.getWmlObjectFactory().createCTAltChunk();
        ac.setId(altChunkRel.getId());
        log.debug("Ac id: " + ac.id)
        return ac
    }

    // If the contract has a template associated with it, then return back a docx based on the template
    // If the contract has no template, create a new package
    def getMLPackage = { contractInstance ->
        def wordMLPackage
        if (contractInstance.template) {
            wordMLPackage = WordprocessingMLPackage.load(new ByteArrayInputStream(contractInstance?.template?.data));
        } else {
            wordMLPackage = WordprocessingMLPackage.createPackage()
        }

        return wordMLPackage
    }

    /* exportWordFromTemplate
     *
     * Finds the places to replace text with content and does so.
     *
     */
    def exportWordFromTemplate = { contractInstance, mainPart, mappings ->
        // Gives us a list of block elements
        def blockElements = mainPart.getJaxbElement().getBody().getEGBlockLevelElts()
        log.debug("Received " + blockElements.size() + " block elements.")

        // Search through each of the elements and ...
        def c = 0
        def locations = [:]
        blockElements.each { element ->
            log.debug("Working on " + element)
            def elementString = element.toString()
            switch(elementString) {
                case ~/\$\{deliverables\}/:
                    log.debug("Found string that contains deliverables at position " + c)
                    locations.put("deliverables", c)
                    break
                case ~/\$\{financials\}/:
                    log.debug("Found string that contains financials at position " + c)
                    locations.put("financials", c)
                    break
                case ~/\$\{timelines\}/:
                    log.debug("Found string that contains timelines at position " + c)
                    locations.put("timelines", c)
                    break
                case ~/\$\{clauses\}/:
                    log.debug("Found string that contains clauses at position " + c)
                    locations.put("clauses", c)
                    break
                case ~/\$\{title\}/:
                    log.debug("Found string that contains title at position " + c)
                    locations.put("title", c)
                    break
                case ~/\$\{timeGenerated\}/:
                    log.debug("Found string that contains timeGenerated at position " + c)
                    locations.put("timeGenerated", c)
                    break
            }
            c++
        }


        //Contents start at 0, zero in our test template is the title bar
        // After we add in an element, we must remove the placeholder.
        mainPart.getContent().add(locations.get("deliverables"), mappings.get("deliverables"))
        blockElements.remove(locations.get("deliverables") + 1)

        mainPart.getContent().add(locations.get("financials"), mappings.get("financials"))
        blockElements.remove(locations.get("financials") + 1)

        mainPart.getContent().add(locations.get("timelines"), mappings.get("timelines"))
        blockElements.remove(locations.get("timelines") + 1)

        mainPart.getContent().add(locations.get("timeGenerated"), mappings.get("timeGenerated"))
        blockElements.remove(locations.get("timeGenerated") + 1)

        mainPart.getContent().add(locations.get("title"), mappings.get("title"))
        blockElements.remove(locations.get("title") + 1)

        // Clasues always have to be inserted last. If we don't, then we have to calculate where in the
        // list they are being added (Because we add two elements instead of one like above). If we added
        // them earlier, this would create formatting issues where clauses would be inserted into other
        // elements.
        def i = locations.get("clauses")
        blockElements.remove(locations.get("clauses"))
        contractInstance?.clauses.each { clause ->
            mainPart.getContent().add(i++, addToWord("/clause-" + i + ".html", clause.description, mainPart))
            mainPart.getContent().add(i++, addToWord("/clause-" + i + "-content.html",
                    clause.content + "(" + clause.vendor + ")",
                    mainPart))
        }
    }

    /* exportWordNoTemplate
     *
     * Builds a document from the ground up, very basic.
     *
     */
    def exportWordNoTemplate = { contractInstance, mainPart, mappings ->
        // create some styled heading...
        mainPart.addStyledParagraphOfText("Title", contractInstance?.description)
        mainPart.addStyledParagraphOfText("Subtitle", "Generated at " + Calendar.getInstance().getTime().toString())

        mainPart.addObject(mappings.get("deliverables"))

        mainPart.addObject(mappings.get("timelines"))

        mainPart.addObject(mappings.get("financials"))

        // Add our list of assets to the document
        def i = 1
        contractInstance?.clauses?.each { clause ->
            mainPart.addObject(addToWord("/clause-" + i + ".html", clause.description, mainPart))
            mainPart.addObject(addToWord("/clause-" + i + "-content.html", clause.content + "(" + clause.vendor + ")",
                    mainPart))
            i++
        }
    }

    def exportWord() {
        def contractInstance = Contract.get(params.id)
        def wordMLPackage = (WordprocessingMLPackage) getMLPackage(contractInstance)
        def mainPart = wordMLPackage.getMainDocumentPart()
        def mappings = [:]

        // Map with the key items, plus the relationship ID from addToWord
        mappings.put("deliverables", addToWord("/deliverables.html", "Deliverables: " + contractInstance?.deliverables,
                mainPart))
        mappings.put("timelines", addToWord("/timelines.html", "Timelines: " + contractInstance?.timelines,
                mainPart))
        mappings.put("financials", addToWord("/financials.html", "Financials: " + contractInstance?.financials,
                mainPart))
        mappings.put("title", addToWord("/title.html", contractInstance?.description, mainPart))

        mappings.put("timeGenerated", addToWord("/timeGenerated.html", "Generated at " +
                Calendar.getInstance().getTime().toString(), mainPart))

        // If the template exists, then we must use it, otherwise create a new document.
        contractInstance.template ? exportWordFromTemplate(contractInstance, mainPart, mappings) :
            exportWordNoTemplate(contractInstance, mainPart, mappings)

        // write out our word doc to disk - is this thread safe?!
        def file = File.createTempFile("wordexport-", ".docx")
        wordMLPackage.save file

        // and send it all back to the browser
        response.setHeader("Content-disposition", "attachment; filename=" + contractInstance?.description + ".docx");
        response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
        response.outputStream << file.readBytes()
        file.delete()
    }

    def print() {
        def contractInstance = Contract.get(params.id)
        if (!contractInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'contract.label', default: 'Contract'),
                    params.id
            ])
            redirect(action: "list")
            return
        }
        [contractInstance: contractInstance]
    }

    def edit() {
        def contractInstance = Contract.get(params.id)
        if (!contractInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'contract.label', default: 'Contract'),
                    params.id
            ])
            redirect(action: "list")
            return
        }

        [contractInstance: contractInstance]
    }

    def update() {
        def contractInstance = Contract.get(params.id)
        if (!contractInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'contract.label', default: 'Contract'),
                    params.id
            ])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (contractInstance.version > version) {
                contractInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [
                                message(code: 'contract.label', default: 'Contract')]
                        as Object[],
                        "Another user has updated this Contract while you were editing")
                render(view: "edit", model: [contractInstance: contractInstance])
                return
            }
        }

        contractInstance.properties = params

        if (!contractInstance.save(flush: true)) {
            render(view: "edit", model: [contractInstance: contractInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [
                message(code: 'contract.label', default: 'Contract'),
                contractInstance.id
        ])
        redirect(action: "show", id: contractInstance.id)
    }

    def delete() {
        def contractInstance = Contract.get(params.id)
        if (!contractInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'contract.label', default: 'Contract'),
                    params.id
            ])
            redirect(action: "list")
            return
        }

        try {
            contractInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [
                    message(code: 'contract.label', default: 'Contract'),
                    params.id
            ])
            redirect(action: "list")
        } catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [
                    message(code: 'contract.label', default: 'Contract'),
                    params.id
            ])
            redirect(action: "show", id: params.id)
        }
    }

    //TODO Finish this off
    // Workflow to guide user through creation of a contract
    def createContractFlow = {
        beginCreate {
            render(view: "selectVendorAndDescription")
            on("next").to "addDeliverables"
        }

        addDeliverables {
            on("next").to "addFinancials"
            on("return").to "beginCreate"
        }

        addFinancials {
            on("next").to "addTimelines"
            on("return").to "addDeliverables"
        }

        addTimelines {
            on("next").to "addClauses"
            on("return").to "addFinancials"

        }

        addClauses {
            on("finished").to "finished"
            on("return").to "addTimelines"
        }

        finished {
            action {
                def description = flow.description
                def vendor = flow.vendor
                def deliverables = flow.deliverables
                def timelines = flow.timelines
                def clauses = flow.clauses
                def financials = flow.financials

                def contract = new Contract(description: description,
                        deliverables: deliverables,
                        timelines: timelines,
                        financials: financials,
                        vendor: vendor).save(flush: true)

                clauses.each { clause ->
                    contract.addToClauses(clause).save(flush: true)
                }
                [contract: contract]
            }
            on(Exception).to "addClauses"
        }
    }
}
