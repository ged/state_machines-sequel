# -*- ruby -*-
#encoding: utf-8

require 'simplecov' if ENV['COVERAGE']

require 'sequel'
require 'rspec'
require 'state_machines'
require 'state_machines/sequel'


DB = Sequel.mock( 'postgres' )


module StateMachines::Sequel::SpecHelpers

	###############
	module_function
	###############

	def new_model_class( table=:test_models, &block )
		model_class = Class.new( Sequel::Model(DB[table]) ) do
			class << self
				attr_writer :db_schema
				alias orig_columns columns
				def columns(*cols)
					return super if cols.empty?
					define_method(:columns){cols}
					@dataset.instance_variable_set(:@columns, cols) if @dataset
					def_column_accessor(*cols)
					@columns = cols
					@db_schema = {}
					cols.each{|c| @db_schema[c] = {}}
				end
			end
		end
		model_class.plugin( :schema )

		if block
			model_class.set_schema( &block )
		else
			model_class.set_schema do
				primary_key :id
				text :name
				text :state, null: false
			end
		end

		model_class.columns( *model_class.schema.columns.map {|col| col[:name]} )

		return model_class
	end

end



# Configure RSpec
RSpec.configure do |config|
	config.run_all_when_everything_filtered = true
	config.filter_run :focus
	config.order = 'random'
	config.mock_with( :rspec ) do |mock|
		mock.syntax = :expect
	end

	config.include( StateMachines::Sequel::SpecHelpers )
end


