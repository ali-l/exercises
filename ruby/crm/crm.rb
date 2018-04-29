require_relative "./contact.rb"
require_relative "./rolodex.rb"


class CRM
	attr_reader :name

	def initialize(name)
		@name = name
		@rolodex = Rolodex.new
	end	

	def print_main_menu
		puts "[1] Add a contact"
		puts "[2] Modify a contact"
		puts "[3] Display all contacts"
		puts "[4] Display one contact"
		puts "[5] Display an attribute"
		puts "[6] Delete a contact"
		puts "[7] Exit"
		puts "Enter a number:"
	end

	def main_menu
		puts "Welcome to #{@name}!"

		while true
			print_main_menu
			input = gets.chomp.to_i
			return if input == 7
			choose_option(input)
		end
	end

	def choose_option(option)
		case option
		when 1 then add_contact
		when 2 then modify_contact
		when 3 then display_all_contacts
		when 4 then display_one_contact
		when 5 then display_attribute
		when 6 then delete_contact
		else
			puts "Invalid option, try again!"
			return
		end
	end

	def add_contact
		print "First name: "
		first_name = gets.chomp
		print "Last name: "
		last_name = gets.chomp
		print "Email: "
		email = gets.chomp
		print "Note: "
		note = gets.chomp
		contact = Contact.new(first_name, last_name, email, note)
		@rolodex.add_contact(contact)
	end

	def display_all_contacts
		@rolodex.contacts.each do |contact|
			puts "#{contact.first_name}, #{contact.last_name}, <#{contact.email}>, #{contact.note}"
		end
	end

	def modify_contact
		print "Enter the first and last name of the contact you wish to modify: "
		name = gets.chomp.split 
		puts "Modify an attribute of #{name[0]} #{name[1]}? (Enter yes or no):"
		confirmation = gets.chomp
		if confirmation == "yes"
			puts "[1] First name"
			puts "[2] Last name"
			puts "[3] Email"
			puts "[4] Note"
			puts "[5] ID" 
			print "Enter a contact attribute to be modified: "
			attribute = gets.chomp.to_i
			print "Enter new value: "
			value = gets.chomp
			@rolodex.modify_contact(name, attribute, value)
		else
			puts "You did not confirm!"
		end
	end

	def delete_contact
		print "Enter the first and last name of the contact you wish to delete: "
		name = gets.chomp.split
		@rolodex.delete_contact(name)
	end

	def display_one_contact
		print "Enter the first and last name of the contact you wish to display: "
		name = gets.chomp.split
		position = @rolodex.find_by_name(name)
		puts "#{@rolodex.contacts[position].first_name}, #{@rolodex.contacts[position].last_name}, <#{@rolodex.contacts[position].email}>, #{@rolodex.contacts[position].note}"
	end

	def display_attribute
		puts "[1] First name"
		puts "[2] Last name"
		puts "[3] Email"
		puts "[4] Note"
		puts "[5] ID" 
		print "Enter a contact attribute to show: "
		attribute = gets.chomp.to_i
		case attribute
		when 1
			@rolodex.contacts.each do |contact|
				puts "#{contact.first_name}"
			end
		when 2
			@rolodex.contacts.each do |contact|
				puts "#{contact.last_name}"
			end
		when 3
			@rolodex.contacts.each do |contact|
				puts "#{contact.email}"
			end
		when 4
			@rolodex.contacts.each do |contact|
				puts "#{contact.note}"
			end
		when 5
			@rolodex.contacts.each do |contact|
				puts "#{contact.id}"
			end
		end
	end

end		

crm = CRM.new("Bitmaker Labs CRM")
crm.main_menu