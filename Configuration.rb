#Base class for configuration routines

class ConfigurationBase

	protected

	#Setting active preference
	def self.active name
		@active = name
	end

	#Setting preference itself
	def self.preference content

		#Initializing array for the first time
		@preferences = {} if @preferences == nil

		if block_given?

			block_result = yield Hash.new

			if block_result.kind_of? Hash
				@preferences[content] = block_result
			end

		else

			#Adding new preference
			@preferences[content.keys.first] = content.values.first

		end

	end

	#Getting actual preference value
	def self.[] name

		#Exiting with nil if nothing defined
		return nil if @preferences == nil

		unless @active == nil

			return @preferences[@active][name]

		else

			return @preferences[@preferences.keys.first][name]

		end

	end

end

#require "ConfigurationBase"

#Configuration class
#Example usage:
#  require "Configuration"
#  puts Configuration[:debug]
#So simple easy!
class Configuration < ConfigurationBase

	#Active preferences collection
	#You should use this to separate various type of settings
	#For example, you can define 'development' and 'production' settings
	#If active preference is not defined, first entry in preferences will be treated as active
	active :development

	#Each preference is defined by preference keyword
	#Class can contain various number of preferences
	preference :development =>
	{
		:debug => true,

		:store =>
		{
			:host	  => "localhost",
			:username => "root",
			:password => "root",
			:database => "gbase"
		}
	}

	#Deployment section
	preference :deployment =>
	{
		:debug => false,

		:store =>
		{
			:host      => "localhost",
			:username  => "deploybase",
			:password  => "somestrongpassword",
			:datatabse => "gbase"
		}

	}

end

