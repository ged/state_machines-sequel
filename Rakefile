#!/usr/bin/env rake

begin
	require 'hoe'
rescue LoadError
	abort "This Rakefile requires hoe (gem install hoe)"
end

GEMSPEC = 'state_machines-sequel.gemspec'


Hoe.plugin :mercurial
Hoe.plugin :signing
Hoe.plugin :deveiate

Hoe.plugins.delete :rubyforge
Hoe.plugins.delete :gemcutter # Remove for public gems

hoespec = Hoe.spec 'state_machines-sequel' do |spec|
	spec.readme_file = 'README.md'
	spec.history_file = 'History.md'
	spec.extra_rdoc_files = FileList[ '*.rdoc', '*.md' ]
	spec.license 'BSD-3-Clause'
	spec.urls = {
		home:   'http://deveiate.org/projects/state_machines-sequel',
		code:   'http://bitbucket.org/ged/state_machines-sequel',
		docs:   'http://deveiate.org/code/state_machines-sequel',
		github: 'http://github.com/ged/state_machines-sequel',
	}

	spec.developer 'Michael Granger', 'ged@FaerieMUD.org'

	spec.dependency 'sequel',                  '~> 4.32'
	spec.dependency 'state_machines',          '~> 0.4'

	spec.dependency 'hoe-deveiate',            '~> 0.7', :developer
	spec.dependency 'simplecov',               '~> 0.7', :developer
	spec.dependency 'rdoc-generator-fivefish', '~> 0.1', :developer

	spec.require_ruby_version( '>=2.0.0' )
	spec.hg_sign_tags = true if spec.respond_to?( :hg_sign_tags= )
	spec.check_history_on_release = true if spec.respond_to?( :check_history_on_release= )
end


ENV['VERSION'] ||= hoespec.spec.version.to_s

# Run the tests before checking in
task 'hg:precheckin' => [ :check_history, :check_manifest, :gemspec, :spec ]

task :test => :spec

# Rebuild the ChangeLog immediately before release
task :prerelease => 'ChangeLog'
CLOBBER.include( 'ChangeLog' )

desc "Build a coverage report"
task :coverage do
	ENV["COVERAGE"] = 'yes'
	Rake::Task[:spec].invoke
end
CLOBBER.include( 'coverage' )


# Use the fivefish formatter for docs generated from development checkout
if File.directory?( '.hg' )
	require 'rdoc/task'

	hoespec.rdoc_locations << "deveiate:/usr/local/www/public/code/#{hoespec.remote_rdoc_dir}"

	Rake::Task[ 'docs' ].clear
	RDoc::Task.new( 'docs' ) do |rdoc|
	    rdoc.main = "README.rdoc"
		rdoc.markup = 'markdown'
	    rdoc.rdoc_files.include( "*.rdoc", "ChangeLog", "lib/**/*.rb" )
	    rdoc.generator = :fivefish
		rdoc.title = 'StateMachines-Sequel'
	    rdoc.rdoc_dir = 'doc'
	end
end

task :gemspec => GEMSPEC
file GEMSPEC => __FILE__
task GEMSPEC do |task|
	spec = $hoespec.spec
	spec.files.delete( '.gemtest' )
	spec.signing_key = nil
	spec.cert_chain = ['certs/ged.pem']
	spec.version = "#{spec.version}.pre#{Time.now.strftime("%Y%m%d%H%M%S")}"
	File.open( task.name, 'w' ) do |fh|
		fh.write( spec.to_ruby )
	end
end

CLOBBER.include( GEMSPEC.to_s )

