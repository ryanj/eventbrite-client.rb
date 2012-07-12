require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "eventbrite-client"
    gem.summary = %Q{A tiny EventBrite API client}
    gem.description = %Q{A with the EventBrite events service. (http://developer.eventbrite.com)}
    gem.email = "ryan.jarvinen@gmail.com"
    gem.homepage = "http://github.com/ryanjarvinen/eventbrite-client.rb"
    gem.authors = ["Ryan Jarvinen"]
    gem.add_development_dependency "rspec", "~> 1.3.0"
    gem.add_dependency "httparty", "~> 0.8.0"
    gem.add_dependency "tzinfo", "~> 0.3.22"

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :irb

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "eventbrite-client #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/*.rb')
end

desc "Runs irb with eventbrite-client lib"
task :irb do
  sh "irb -r 'lib/eventbrite-client'"
end
