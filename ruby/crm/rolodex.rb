class Rolodex
	attr_reader :contacts
	@@index = 1000

	def initialize
		@contacts = []
	end

	def add_contact(contact)
		contact.id = @@index
		@@index += 1
		@contacts << contact
	end

	def find_by_name(name)
		@contacts.rindex {|contact| (contact.first_name == name[0]) && (contact.last_name == name[1])}
	end

	def modify_contact(name, attribute, value)
		case attribute
		when 1 then @contacts[find_by_name(name)].first_name = value
		when 2 then @contacts[find_by_name(name)].last_name = value
		when 3 then @contacts[find_by_name(name)].email = value
		when 4 then @contacts[find_by_name(name)].note = value
		when 5 then @contacts[find_by_name(name)].id = value
		end
	end

	def delete_contact(name)
		@contacts.delete_at(find_by_name(name))
	end

end