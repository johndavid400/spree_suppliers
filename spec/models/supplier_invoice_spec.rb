require 'spec_helper'

describe Supplier do
  it { should belong_to(:supplier_invoice) }
  it { should have_many(:invoice_items) }
end
