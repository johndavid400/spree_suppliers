require 'spec_helper'

describe Supplier do

  FactoryGirl.build(:supplier, :name => 'Joe', :title => "Joe's Plumbing")

  it { should have_one(:user) }
  it { should have_many(:supplier_invoices) }
  it { should have_many(:images) }
  it { should have_many(:products) }

  it { should has_and_belongs_to_many(:taxons) }
end
