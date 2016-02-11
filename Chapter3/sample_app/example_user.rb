class User
	attr_accessor :name, :email

	def initialize(attribues = {})
		@name = attribues[:name]
		@email = attribues[:email]
	end

	def formatted_email
		"#{@name} <#{email}>"
	end
end