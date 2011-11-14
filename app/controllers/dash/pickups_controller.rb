class Dash::PickupsController < Dash::BaseController
  def new
    @pickups = current_user.supplier.pickups
    @locations = (current_user.supplier.pickup_locations + PickupLocation.locate).uniq
  end

  def create_dates dates
    dates = dates[0].split(',')
    new_dates = []
    dates.each do |d|
      begin
        new_dates.push(Date.strptime(d, "%m/%d/%Y"))
      rescue
        return false
      end
    end
    pickups = []
    new_dates.each do |day|
      pickups.push(PickupDate.new({:day => day}))
    end
    pickups
  end

  def create 
    @pickup = current_user.supplier.pickups.build ({:pickup_location_id => params[:locations]})
    pickup_dates = create_dates(params[:dates])
    if pickup_dates != false
      @pickup.pickup_dates = pickup_dates
    else
      flash[:error] = "Errors in creating dates"
      redirect_to dash_pickups_path and return
    end
    if @pickup.save
      redirect_to new_dash_pickup_path, :message => "Successful creation"
    else
      redirect_to new_dash_pickup_path, :error => "Errors in creating dates"
    end
  end

end
