import ca.shaw.contractmanagement.Clause
import ca.shaw.contractmanagement.Contract
import ca.shaw.contractmanagement.Vendor
import grails.util.Environment

class BootStrap {

	def init = { servletContext ->
		switch (Environment.current) {
			// For dev environment, populate some data on start
			// Two vendors, two clauses
			// One contract for first vendor with first clause
			case Environment.DEVELOPMENT:
				if (!Vendor.count()) {
					def vendorOne = new Vendor(vendorName: "Vendor 1").save(failOnError: true)
					def vendorTwo = new Vendor(vendorName: "Vendor 2").save(failOnError: true)
					def clauseOne = new Clause(description: "Clause 1", content: "Content for clause 1", vendor: vendorOne).save(failOnError:true)
					def clauseTwo = new Clause(description: "Clasue 2", content: "Content for clause 2", vendor: vendorTwo).save(failOnError:true)
					def contractOne = new Contract(description: "SOW1", deliverables: "Deliverables", timelines: "Timelines", 
						financials: "Financials", vendor: vendorOne).save(failOnError:true)
					vendorOne.addToClauses(clauseOne).save(failOnError:true)
					vendorTwo.addToClauses(clauseTwo).save(failOnError:true)
					vendorOne.addToContracts(contractOne).save(failOnError:true)
					contractOne.addToClauses(clauseOne).save(failOnError:true)
				}
				break
		}
	}
	
	def destroy = {
	}
}
