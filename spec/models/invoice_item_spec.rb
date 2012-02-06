require 'spec_helper'

describe InvoiceItem do
  it { should belong_to(:supplier_invoice) }
  it { should belong_to(:line_item)}
end
