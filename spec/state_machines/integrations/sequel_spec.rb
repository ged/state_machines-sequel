#!/usr/bin/env rspec -cfd
#encoding: utf-8

require_relative '../../spec_helper'

require 'rspec'
require 'state_machines/sequel'



describe StateMachines::Integrations::Sequel do

	let( :model_class ) { StateMachines::Sequel::SpecHelpers::TestModel }
	let( :non_model_class ) { Class.new }


	it "is registered" do
		expect( StateMachines::Integrations.list ).to include( described_class )
	end


	it "only registers itself once" do
		expect( StateMachines::Integrations.list.count(described_class) ).to eq( 1 )
	end


	it "has an integration name" do
		expect( described_class.integration_name ).to eq( :sequel )
	end


	it "matches Sequel::Model classes" do
		expect( StateMachines::Integrations.match(model_class) ).to be( described_class )
	end


	it "doesn't match non-Sequel::Model classes" do
		expect( described_class.matches?(non_model_class) ).to be_falsey
	end


	it "defaults the action to `save`" do
		expect( described_class.defaults[:action] ).to eq( :save )
	end

end

