require 'spec_helper'

describe SupplierInvoice do
  it { should belong_to(:supplier) }
  it { should have_many(:invoice_items) }
end
