require 'spec_helper'

describe Supplier do

  it { should belong_to(:user) }
  it { should have_many(:supplier_invoices) }
  it { should have_many(:images) }
  it { should have_many(:products) }

  it { should belong_to(:taxons) }
  it { should have_many(:taxons) }
#  it { should has_and_belongs_to_many(:taxons) }
end
