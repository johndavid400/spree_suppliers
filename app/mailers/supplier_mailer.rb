class SupplierMailer < ActionMailer::Base

  def invoice_email(invoice)
    @invoice = invoice
    @supplier = @invoice.supplier
    @fee = 0.14
    @delivery = Delivery.find(:all, :conditions => { :order_id => @invoice.order.id, :supplier_id => @invoice.supplier_id})
    mail(:to => @supplier.email, :subject => "Sale on Freshfully.com!", :from => "support@freshfully.com")
  end

end
