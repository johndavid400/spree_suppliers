# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_suppliers'
  s.version     = '1.0.0'
  s.summary     = 'This gem adds multiple suppliers to spree, with the ability to associate products with suppliers. Suppliers can be managed from the Admin interface.'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.9.2'

  s.author            = 'JD Warren and Han Dao'
  s.email             = 'jd@isotope11.com'
  s.homepage          = 'http://github.com/johndavid400/spree_suppliers'
  s.rubyforge_project = 'spree_suppliers'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 0.70.3'
  s.add_development_dependency 'rspec-rails'
end

