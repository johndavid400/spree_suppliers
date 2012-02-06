require 'spec_helper'

describe Supplier do

  it { should belong_to(:user) }
  it { should have_many(:supplier_invoices) }
  it { should have_many(:images) }
  it { should have_many(:products) }

end
