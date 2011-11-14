class Admin::PickupLocationsController < Admin::BaseController

  def new
    @pickup_location = PickupLocation.new()
  end

  def show 
    @location = PickupLocation.find(params[:id])
  end

  def create
    @pickup_location = PickupLocation.create(params[:pickup_location])
#    @pickup_location = current_user.supplier.pickup_locations.build(params[:pickup_location])
    if @pickup_location.save
      @pickup_location.hours.create(business_hours)
      redirect_to admin_pickups_path, :notice => "New location added"
    else
      render "new", :notice => "Failed to create location"
    end
  end


  def edit
    @pickup_location = PickupLocation.find(params[:id])
    @locations = [PickupLocation.first]
  end

  def update
    @pickup_location = PickupLocation.find(params[:id])
    if @pickup_location.update_attributes(params[:pickup_location])
      if @pickup_location.hours.first.update_attributes(business_hours)
        redirect_to edit_admin_pickup_location_path, :notice => "Pickup Location and Hours updated"
      else
        redirect_to edit_admin_pickup_location_path, :notice => "Pickup Location updated"
      end
    else
      render "edit"
    end
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

end
