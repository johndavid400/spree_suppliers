require 'spec_helper'

describe Supplier do
  it { should belong_to(:supplier_invoice) }
  it { should belong_to(:line_item)}
end
