# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_suppliers'
  s.version     = '1.0.5'
  s.summary     = 'This gem adds multiple suppliers to spree, with the ability to associate products with suppliers. Suppliers can be managed from the Admin interface.'
  s.description = 'This gem (spree extension) provides support for multiple suppliers in one store. Products should be assigned to the supplier that they belong to, which allows you to select a supplier and view only their products. Suppliers can be associated with Taxons that allow the customer to search for suppliers by taxon. Orders are also broken up into supplier invoices (one for each different supplier in the order), which list only the products that were purchased from that supplier. A mailer is in place to send each supplier their unique invoice descrbing what products they have sold and to who. The spree order mailer has also been modified to show all of the supplier invoices to the customer, along with the standard spree order number and info. The checkout process is combined so the customer only makes one transaction - the transaction can then be divided up amongst the suppliers involved in the transaction, according to the supplier_invoices. There is also an option for the site administrator to charge a percentage fee on each transaction to suppliers (this is currently set to 0%, but can be changed).'

  s.required_ruby_version = '>= 1.9.2'

  s.author            = 'JD Warren and Han Dao'
  s.email             = 'jd@isotope11.com'
  s.homepage          = 'http://github.com/johndavid400/spree_suppliers'
  s.rubyforge_project = 'spree_suppliers'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>=2.4.0'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'cucumber-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'nokogiri'
  s.add_development_dependency 'shoulda'

end

