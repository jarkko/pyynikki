require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'

require File.join(File.dirname(__FILE__), 'version')
pkg_files = ["lib/**/*.rb", "test/**/*.rb", "*.rb", "MIT-LICENSE", "README", "Rakefile", "changelog"]

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the l10n_simplified plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Create documentation for the l10n_simplified plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'LocalizationSimplified'
  rdoc.options << '--line-numbers' << '--inline-source' << '--charset=UTF-8'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('changelog')
  rdoc.rdoc_files.include('lib/localization_simplified.rb')
  rdoc.rdoc_files.include('lib/lang_en.rb')
  rdoc.rdoc_files.include('version.rb')
  #rdoc.rdoc_files.include('lib/**/*.rb')
end


# TODO: look at http://mandhro.com/2006/07/03/publising-rails-plug-ins-with-rake/
# that can probably also release to RubyForge
# TODO: the Hoe plugin can probably also do that 
# see http://seattlerb.rubyforge.org/hoe/ or
# http://drnicwilliams.com/2006/10/11/generating-new-gems/
desc 'Create release packages for the l10n_simplified plugin'
Rake::PackageTask.new("l10n-simplified", L10N_VERSION) do |p|
  p.need_tar = true
  p.need_zip = true
  p.package_files.include(pkg_files)
end



spec = Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'l10n-simplified'
  s.version           = L10N_VERSION
  s.date              = '2008-01-01'
  s.summary           = 'really simple localization (one language)'
  s.requirements << 'none'
  s.authors           = ["Jesper Rønn-Jensen"]
  s.email             = "jesperrr@gmail.com"
  s.homepage          = "http://rubyforge.org/projects/l10n-simplified"
  s.rubyforge_project = "l10n-simplified"
# s.files             = 
 s.description        = %q{
   The goal is to have a dead simple plugin for one-language (non-english) Rails applications. 
   Many of the existing localization / internationalization plugins are too big for this and 
   hard to get started with. Just dump this plugin in /vendor/plugins/, set your language and 
   off you go.
 }
end

Rake::GemPackageTask.new(spec) do |pkg|
 pkg.need_zip = true
 pkg.need_tar = true
 pkg.package_files.include(pkg_files)
end