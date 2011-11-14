Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_suppliers'
  s.version     = '0.60.4'
  s.summary     = 'Add suppliers to products.'
  s.description = 'This gem adds multiple supplier/vendor support to spree by allowing mutliple vendors to be created and managed in the admin panel, so that each vendor can have a mini-store listing only their products. The default spree feel and operation of a combined products index showing all available products in the store is left intact, so customers can buy items from different vendors with a single checkout process. This extension can be used to simply add multiple supplier support to show off your vendors, or it can be used as a 3rd party gateway to link customers directly to suppliers.'
  s.required_ruby_version = '>= 1.9.2'

  s.author            = 'JD Warren and Han Dao (Isotope11.com)'
  s.email             = 'jd@isotope11.com'
  s.homepage          = 'http://www.isotope11.com'
  s.rubyforge_project = 'spreecommerce'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 0.60.3')
end
