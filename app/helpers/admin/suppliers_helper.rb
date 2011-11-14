module Admin::SuppliersHelper
  def find_minutes outcome
    minutes = outcome.scan(/:\d+/)
    minutes.each do |s|
      s.delete!(":")
    end
    minutes
  end

  def find_periods outcome
    periods = outcome.scan(/(AM|PM)/)
  end

  def find_hours outcome
    hours = outcome.scan(/\d+:/)
    hours.each do | s|
      s.delete!(":")
    end
    hours
  end
end
