# -*- ruby -*-
#encoding: utf-8

require 'sequel'
require 'state_machines'


# Toplevel namespace
module StateMachines::Sequel

	# Package version
	VERSION = '0.0.1'

	# Version control revision
	REVISION = %q$Revision: ed192967e2af $


	# Autoload the machine mixins when they're used
	autoload :ErrorHandling, 'state_machines/sequel/error_handling'


end # module StateMachines::Sequel

require 'state_machines/integrations/sequel'
StateMachines::Integrations.register( StateMachines::Integrations::Sequel )

