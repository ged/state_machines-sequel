# -*- ruby -*-
#encoding: utf-8

require 'sequel'
require 'state_machines'
require 'state_machines/integrations/base'


# Adds support for integrating state machines with Sequel::Model classes.
module StateMachines::Integrations::Sequel
	include StateMachines::Integrations::Base,
		StateMachines::Sequel::ErrorHandling


	# Defaults for state machines that use this integration
	STATE_MACHINE_DEFAULTS = {
		action: :save,
	}.freeze


	### Return the default options for state machines that use this integration.
	def self::defaults
		return STATE_MACHINE_DEFAULTS.dup
	end


	### Integration API -- returns true if the Sequel integration should be used for
	### the specified +stateful_class+.
	def self::matches?( stateful_class )
		return stateful_class < Sequel::Model
	end

end # module StateMachines::Integrations::Sequel

