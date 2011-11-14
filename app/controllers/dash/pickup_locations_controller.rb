class Dash::PickupLocationsController < Dash::BaseController
  def new
    @pickup_locations = (current_user.supplier.pickup_locations + PickupLocation.locate).uniq
    @pickup_location = PickupLocation.new()
  end

  def business_hours
    days = {}
    ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"].each do |day|
      days.merge!({day.downcase.to_sym => params["#{day}_begin"] + ":" + params["#{day}_begin_mins"] + " " + params["#{day}_begin_type"].upcase + " to " + params["#{day}_end"] + ":" + params["#{day}_end_mins"] + " " + params["#{day}_end_type"].upcase} )
      if params["#{day}_closed"] == "Closed"
        days.merge!({day.downcase.to_sym => "Closed"})
      end
    end
    days
  end

  def create 
    @pickup_location = current_user.supplier.pickup_locations.build(params[:pickup_location])
    if @pickup_location.save
      @pickup_location.hours.create(business_hours)
      redirect_to new_dash_pickup_location_path, :notice => "New location added"
    else
      render "new", :notice => "Failed to create location"
    end  
  end
end
