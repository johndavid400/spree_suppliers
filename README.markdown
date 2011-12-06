# Spree Suppliers Extension

This is an extension to run on top of spree 0.60.3 rails ecommerce engine.

This extension provides functionality to use multiple suppliers/vendors, each selling their own products, but using a unified listing view so the customer is not affected by this and only makes one transaction. On the backend, smaller sub-orders called supplier invoices are created by grouping the products in an order by each product's supplier_id. A subtotal is generated for each supplier invoice, so the spree administrator can send out invoices to each supplier.

______________________________

## Installation:

### you must first have a running rails app:

- rails new spree_suppliers_test
- cd spree_suppliers_test

### Now set up your Gemfile and install:

####  Add to Gemfile:

- gem 'rails', '3.0.9'
- gem 'sqlite3'
- gem 'spree', '0.60.3'
- gem 'spree_suppliers', '0.60.3'

#### then run:

- bundle install
- rake spree:install
- rake spree_suppliers:install
- rake db:migrate
- rake db:seed
- rake db:admin:create

### That's it for installation!

- rails s
- visit localhost:3000

______________________________

### Alternatively,
To get the latest updates, you can install the spree_suppliers extension from github instead of rubygems:


#### Add to Gemfile:

- gem 'spree_suppliers', :git => 'git://github.com/johndavid400/spree_suppliers.git'

#### run the following:

- bundle install
- rake spree_suppliers:install
- rake db:migrate

______________________________

## Checkout Process

Before being able to check out with the new changes, go to /admin and do the following things:

1. create a vendor (with valid address)
2. create a shipping method (make sure to select the correct zone for your area)
3. create a payment method (use "check" to test with)
4. edit vendor - add shipping option
5. add pickup and pickup location for vendor
6. add product for vendor - then edit to assign new product to the vendor

Go through checkout process normally, then check orders page on the admin panel to view the details of an order and all supplier invoices that are created.

______________________________

## Supplier Invoice Mailer

There is a mailer in place that will send each individual supplier an email anytime a purchase is made from them. It will not show them the entire order, only the products purchased from them. The mailer is disabled (commented out) as there is no email smtp information yet. Once you fill this in, you can re-enable the mailer to send out emails.

#### To change smtp settings for supplier invoice: 

- config/initializers/supplier_invoice_mailer.rb

#### to enable supplier invoice mailer, uncomment line:238:

- lib/spree_suppliers.rb


