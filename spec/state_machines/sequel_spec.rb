#!/usr/bin/env rspec -cfd

require_relative '../spec_helper'

require 'state_machines'
require 'state_machines/sequel'


describe StateMachines::Sequel do

	let( :model ) { new_model_class(:test_models) }
	let( :machine ) { StateMachines::Machine.new(model, integration: :sequel) }

	context "with an empty machine" do

		it "saves as its action" do
			expect( machine.action ).to eq( :save )
		end


		it "uses transactions" do
			expect( machine.use_transactions ).to be_truthy
		end


		it "doesn't have any before callbacks" do
			expect( machine.callbacks[:before] ).to be_empty
		end


		it "doesn't have any after callbacks" do
			expect( machine.callbacks[:after] ).to be_empty
		end

	end


	describe "multiple state columns" do

		let( :model ) do
			new_model_class( :vehicles ) do
				primary_key :id
				text :state, null: false
				text :status, null: false
			end
		end


		let( :state_machine ) do
			StateMachines::Machine.new( model, initial: :parked, integration: :sequel )
		end

		let( :status_machine ) do
			StateMachines::Machine.new( model, :status, initial: :idling, integration: :sequel )
		end


		it "initializes each state" do
			record = model.new
			expect( record.state ).to eq( 'parked' )
			expect( record.status ).to eq( 'idling' )
		end

	end

end

