# Loads seed data out of default dir
SpreeCore::Engine.load_seed if defined?(SpreeCore)

puts "Create payment method"
ii = PaymentMethod::Check.create :name => "test", :active => true, :environment => "development"

puts "Create shipping method"

s = ShippingMethod.new :name => "Shipping", :zone => Zone.find_by_name("North America")
s.calculator = Calculator::FlatRate.new :calculable => s.id, :calculable_type => "ShippingMethod"
s.save

puts "Create Users"

@admin = User.create :email => "spree@example.com", :password => "password", :password_confirmation => "password", :first_name => "Spree", :last_name => "Cat", :description => "Sup."
@admin.roles = [Role.first]
@admin.save
@user = User.create :email => "test@example.com", :password => "password", :password_confirmation => "password"
@user2 = User.create :email => "test2@example.com", :password => "password", :password_confirmation => "password"

puts"Create Taxons"

t = Taxonomy.create :name => "Producers"
s = Taxonomy.create :name => "Products"

supplier = t.taxons.create :name => "Suppliers", :parent_id => t.id
toys = t.taxons.create :name => "Toys", :parent_id => t.id
candy = t.taxons.create :name => "Candy", :parent_id => s.id
t.taxons.create :name => "Clothing", :parent_id => s.id
t.taxons.create :name => "Recipes", :parent_id => t.id

s.taxons.create :name => "Potent Potables", :parent_id => t.id
s.taxons.create :name => "Childrens", :parent_id => s.id
s.taxons.create :name => "Baked Goods", :parent_id => s.id


puts"Create Suppliers"

supplier1 = Supplier.create(:name => "Farmer Bob", :featured => true, :notes => "Farmer Bob is a specialist in growing watermelon, squash, and tomatoes", :title => "Farmer Bob's Market")
supplier1.taxons = [supplier]
supplier1.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "chicken.jpg")))
supplier1.save

supplier2 = Supplier.create(:name => "Maury", :title => "Moonshine Maury", :featured => true)
supplier2.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "goat.jpg")))
supplier2.taxons = [supplier]
supplier2.save

supplier3 = Supplier.create(:name => "Fresh", :title => "Freshfully Farms", :featured => true)
supplier3.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "watermelon.jpg")))
supplier3.taxons = [supplier]
supplier3.save

supplier4 = Supplier.create(:name => "Betty", :title => "Betty's Bees", :featured => true)
supplier4.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "flower.jpg")))
supplier4.taxons = [supplier]
supplier4.save

supplier5 = Supplier.create(:name => "Larry", :title => "Larry's Lemonade", :description => "I am a supplier")
supplier5.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "cow.jpg")))
supplier5.taxons = [supplier]
supplier5.save

supplier6 = Supplier.create(:name => "Gary", :title => "Gardener Gary")
supplier6.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "banana.jpg")))
supplier6.taxons = [supplier]
supplier6.save

puts "Creating Sample Products"

a = Product.create :name => "Grapes", :price => "4.99", :permalink => "grapes", :supplier_id => supplier1.id, :available_on => 3.days.ago
a.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "grapes.jpg")))
a.taxons = [candy]
a.save

c = Product.create :name => "Banana", :price => "6.99", :permalink => "banana", :supplier_id => supplier3.id, :available_on => 3.days.ago
c.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "banana.jpg")))
c.taxons = [candy]
c.save

d = Product.create :name => "Corn", :price => "4.99", :permalink => "corn", :supplier_id => supplier4.id, :available_on => 3.days.ago
d.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "cow.jpg")))
d.taxons = [candy]
d.save

e = Product.create :name => "Blueberries", :price => "4.99", :permalink => "blueberries", :supplier_id => supplier4.id, :available_on => 3.days.ago
e.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "blueberry.jpg")))
e.taxons = [candy]
e.save

f = Product.create :name => "Strawberries", :price => "3.99", :permalink => "strawberries", :supplier_id => supplier5.id, :available_on => 3.days.ago
f.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "strawberry.jpg")))
f.taxons = [candy]
f.save

g = Product.create :name => "Oranges", :price => "2.99", :permalink => "oranges", :supplier_id => supplier6.id, :available_on => 3.days.ago
g.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "orange.jpg")))
g.taxons = [candy]
g.save

h =Product.create :name => "Cranberry", :price => "0.99", :permalink => "cranberry", :supplier_id => supplier1.id, :available_on => 3.days.ago
h.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "cherries.jpg")))
h.taxons = [candy]
h.save

i = Product.create :name => "Squash", :price => "2.99", :permalink => "squash", :supplier_id => supplier2.id, :available_on => 3.days.ago
i.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "squash.jpg")))
i.taxons = [toys]
i.save

j = Product.create :name => "Green Beans", :price => "1.99", :permalink => "greenbeans", :supplier_id => supplier3.id, :available_on => 3.days.ago
j.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "greenbeans.jpg")))
j.taxons = [toys]
j.save

g = Product.create :name => "Floranges", :price => "2.99", :permalink => "floranges", :supplier_id => supplier6.id, :available_on => 3.days.ago
g.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "orange.jpg")))
g.taxons = [candy]
g.save

h =Product.create :name => "Handberry", :price => "0.99", :permalink => "handberry", :supplier_id => supplier1.id, :available_on => 3.days.ago
h.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "cherries.jpg")))
h.taxons = [candy]
h.save

i = Product.create :name => "Tosh.0", :price => "2.99", :permalink => "tosh", :supplier_id => supplier2.id, :available_on => 3.days.ago
i.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "squash.jpg")))
i.taxons = [toys]
i.save

j = Product.create :name => "Kidney Beans", :price => "1.99", :permalink => "beans", :supplier_id => supplier3.id, :available_on => 3.days.ago
j.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "greenbeans.jpg")))
j.taxons = [toys]
j.save

j = Product.create :name => "Liver Beans", :price => "1.99", :permalink => "liver beans", :supplier_id => supplier3.id, :available_on => 3.days.ago
j.images.create(:attachment => File.open(File.join(Rails.root, "db", "seeds", "images", "greenbeans.jpg")))
j.taxons = [toys]
j.save



puts "Finished Seed Data"
