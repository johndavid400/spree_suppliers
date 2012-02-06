require 'spec_helper'

describe Supplier do
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:title) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:title) }

  it { should have_one(:user) }

  it { should have_many(:supplier_invoices) }
  it { should have_many(:images) }
  it { should have_many(:products) }

  it { should have_many_and_belong_to(:taxons) }
end
