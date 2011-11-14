class Admin::PickupsController < Admin::BaseController

  def index
    if current_user.has_role?("vendor")
      @suppliers = [current_user.supplier]
    else
      @suppliers = Supplier.all.select{|r| !r.pickups.empty?}
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    if current_user.has_role?("vendor")
      @pickups = current_user.supplier.pickups
      @locations = (current_user.supplier.pickup_locations + PickupLocation.locate).uniq
    else
      @pickups = Pickup.all
      @locations = PickupLocation.all
    end
    @pickup_location = PickupLocation.new()
    @pickup = Pickup.new
    @suppliers = Supplier.all
  end

  def create 
    pickup_location_id = params[:pickup_location_id]
    supplier_id = params[:supplier_id]
    @pickup = Pickup.create(:supplier_id => supplier_id, :pickup_location_id => pickup_location_id, :name => PickupLocation.find_by_id(pickup_location_id).location_name)
    pickup_dates = create_dates(params[:dates])
    if pickup_dates != false
      @pickup.pickup_dates = pickup_dates
    else
      flash[:error] = "Errors in creating dates"
      redirect_to admin_pickups_path and return
    end
    if @pickup.save
      redirect_to admin_pickups_path, :message => "Successful creation"
    else
      redirect_to admin_pickups_path, :error => "Errors in creating dates"
    end
  end

  def edit
    @pickups = Pickup.all
    @locations = [PickupLocation.first]
  end

  def update
    @pickup = Pickup.find(params[:id])
    if @pickup.update_attributes(params[:pickup])
      redirect_to edit_admin_pickup_path, :notice => "Pickup updated"
    else
      render "edit"
    end
  end

  def destroy
    @pickup = Pickup.find(params[:id])
    @pickup.destroy
    flash[:notice] = "Pickup Successfully deleted."
    redirect_to admin_pickups_url
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

end
