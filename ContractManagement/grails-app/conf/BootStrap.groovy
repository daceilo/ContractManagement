import ca.shaw.contractmanagement.Clause
import ca.shaw.contractmanagement.Contract
import ca.shaw.contractmanagement.Role
import ca.shaw.contractmanagement.User
import ca.shaw.contractmanagement.UserRole
import ca.shaw.contractmanagement.Vendor
import grails.util.Environment

class BootStrap {
	def springSecurityService

	def init = { servletContext ->
		// For all environments, we want to setup our security
		def userRole = Role.findByAuthority("ROLE_USER") ?: new Role(authority: "ROLE_USER").save(flush:true, failOnError: true)
		def adminRole = Role.findByAuthority("ROLE_ADMIN") ?: new Role(authority: "ROLE_ADMIN").save(flush:true, failOnError:true)

		// Will be added if they don't exist
		def baseUsers = [
					'admin' : adminRole,
					'user'  : userRole
				]

		// If the users don't exist, then add the default ones
		def users = User.list()
		if (!users) {
			baseUsers.each { username, role ->
				def user = new User(
						username: username,
						password: 'password',
						enabled: true).save(flush:true, failOnError: true)

				UserRole.create user, role, true

			}


		}
		
		assert User.count() == 2
		assert Role.count() == 2
		assert UserRole.count() == 2

		switch (Environment.current) {
			// For dev environment, populate some data on start
			// Two vendors, two clauses
			// One contract for first vendor with first clause
			case Environment.DEVELOPMENT:
				def content = '<p><strong><span style="text-decoration: underline;">Content for clause 1</span></strong></p>\n' +
				'<p>This is the content for the first clause. There should be <em>various</em>&nbsp;forms of HTML formatting ' +
				'that will need to be applied to <span style="text-decoration: line-through;">HTML</span>&nbsp;' +
				'<strong>WORD.</strong></p> <p style="padding-left: 30px;">Does it process this indent?</p> \n<p>\n' +
				' <ul> \n<li>How about a bullted list?</li>\n </ul> \n</p>'

				//If there are no vendors, there's nothing else due to relationships.
				if (!Vendor.count()) {
					def vendorOne = new Vendor(vendorName: "Vendor 1").save(flush:true, failOnError: true)
					def vendorTwo = new Vendor(vendorName: "Vendor 2").save(flush:true, failOnError: true)
					def clauseOne = new Clause(description: "Clause 1", content: content, vendor: vendorOne).save(flush:true, failOnError:true)
					def clauseTwo = new Clause(description: "Clasue 2", content: "Content for clause 2", vendor: vendorTwo).save(flush:true, failOnError:true)
					def contractOne = new Contract(description: "SOW1",
							deliverables: '<p><strong>Deliverables</strong></p>',
							timelines: '<p><em>Financials</em></p>',
							financials: '<p><span style="text-decoration: underline;">Timelines</span></p>',
							vendor: vendorOne).save(flush:true, failOnError:true)
					vendorOne.addToClauses(clauseOne).save(flush:true, failOnError:true)
					vendorTwo.addToClauses(clauseTwo).save(flush:true, failOnError:true)
					vendorOne.addToContracts(contractOne).save(flush:true, failOnError:true)
					contractOne.addToClauses(clauseOne).save(flush:true, failOnError:true)
				}
				break
		}


	}

	def destroy = {
	}
}
