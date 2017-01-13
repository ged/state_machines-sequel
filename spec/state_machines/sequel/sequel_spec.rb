#!/usr/bin/env rspec -cfd

require_relative '../../spec_helper'

require 'state_machines'
require 'state_machines/sequel'


describe StateMachines::Sequel, "error handling" do

	let( :model ) { new_model_class }
	let( :machine ) { StateMachines::Machine.new(model, integration: :sequel) }
	let( :record ) { model.new }


	it "is able to describe current errors" do
		record.errors.add( :id, 'cannot be blank' )
		record.errors.add( :state, 'is invalid' )
		expect( machine.errors_for(record) ).to include(
			'id cannot be blank',
			'state is invalid'
		)
	end


	it "describes the current errors as `transition halted` if there are no validation errors" do
		expect( machine.errors_for(record) ).to match( /transition halted/i )
	end


	

end

