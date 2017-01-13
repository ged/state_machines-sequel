# -*- ruby -*-
#encoding: utf-8

require 'state_machines/sequel' unless defined?( StateMachines::Sequel )


# Error handling methods for state machines using the Sequel integration.
module StateMachines::Sequel::ErrorHandling


	### Adds a validation error to the given object
	def invalidate( object, attribute, message, values=[] )
		message = self.generate_message( message, values )
		attribute = self.attribute( attribute )
		object.errors.add( attribute, message )
	end


	### Describes the current validation errors on the given object.  If none
	### are specific, then the default error is interpeted as a "halt".
	def errors_for( object )
		if !object.errors.empty?
			return object.errors.full_messages.join( ', ' )
		else
			return 'Transition halted'
		end
	end


end # module StateMachines::Sequel::ErrorHandling
