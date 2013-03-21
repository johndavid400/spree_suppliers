# Spree Suppliers Extension

This is an extension to run on top of Spree 1.3.2 rails ecommerce engine.

This gem (spree extension) provides support for multiple suppliers in one store, each selling their own products. Products should be assigned to the supplier that they belong to, which allows the customer to select a supplier and view only their products. Suppliers can be associated with Taxons, which allows the customer to search for supplier's products by taxon.

Orders are also broken up into individual supplier_invoices upon order completion (one for each different supplier in the order), which list only the products that were purchased from that supplier. A mailer is in place (though disabled until you add your email smtp credentials) to send each supplier their unique invoice describing what products they have sold and to whom. The spree order mailer has also been modified to show all of the supplier invoices to the customer, along with the standard spree order number and info. The checkout process is combined so the customer only makes one transaction - the transaction can then be divided up amongst the suppliers involved in the transaction, according to the supplier_invoices. There is also an option for the site administrator to charge a percentage fee on each transaction to suppliers (this is currently set to 0%, but can be changed).

______________________________

## Installation:

### you must first have a running rails app:

    gem install rails, "~> 3.2.13"
    gem install spree, "~> 1.3.2"
    rails new spree_suppliers_test
    spree install spree_suppliers_test
    cd spree_suppliers_test

### Now set up your Gemfile and install:

####  Add to Gemfile:

    gem 'spree_suppliers', :git => 'git://github.com/johndavid400/spree_suppliers.git', :branch '1.3.2'

#### then run the following:

    bundle install
    rails g spree_suppliers:install
    rake db:migrate
    rake db:seed
    rake db:admin:create

- (If you would like some sample seed data for suppliers, copy the seeds.rb file and seeds folder from the gem to your project home db/)

### That's it for installation!

    rails s

- visit localhost:3000

______________________________

#### run the following:

    bundle install
    rake spree_suppliers:install
    rake db:migrate

______________________________

## Checkout Process

Before being able to check out with the new changes, go to /admin and do the following things:

1. create a supplier
2. create a shipping method
3. create a payment method (use "check" to test with)
6. add product for supplier to use - then edit product and assign to to the desired supplier

Go through checkout process normally, then check orders page on the admin panel to view the details of an order and all supplier invoices that are created.

______________________________

## Supplier Invoice Mailer

There is a mailer in place that will send each individual supplier an email anytime a purchase is made from them. It will not show them the entire order, only the products purchased from them. The mailer is disabled (commented out) as there is no email smtp information yet. Once you fill this in, you can re-enable the mailer to send out emails.

#### To change smtp settings for supplier invoice:

- config/initializers/supplier_invoice_mailer.rb

#### to enable supplier invoice mailer, uncomment line:84 and line:95:

- lib/spree_suppliers.rb

