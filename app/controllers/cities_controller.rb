class CitiesController < Spree::BaseController
  # GET /cities
  # GET /cities.xml
  def index
    @cities = City.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cities }
    end
  end

  def suppliers_by_taxon name
    @suppliers.select{|s| s.taxons.select{|t| t.name == name }.size > 0}
  end
  # GET /cities/1
  # GET /cities/1.xml
  def show
    @city = City.find_by_slug(params[:id])
    @articles = @city.articles.select{|x| x.featured == true}.take(3)
    @suppliers = Supplier.current_city(@city.id)
    @recipes = @city.recipes.take(4)
    @products = @suppliers.map {|s| s.products}.flatten.take(6)
    @specialties = @products.select {|p| p.specialty == true}
    @locavore = User.find_by_city_id(@city.id)
    @farmers = suppliers_by_taxon("Farms").to_gmaps4rails
    @markets = suppliers_by_taxon("Farmer's Market").to_gmaps4rails
    @restaurants = suppliers_by_taxon("Restaurants").to_gmaps4rails
    @json = @suppliers.to_gmaps4rails
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @city }
    end
  end

  # GET /cities/new
  # GET /cities/new.xml
  def new
    @city = City.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @city }
    end
  end

  # GET /cities/1/edit
  def edit
    @city = City.find(params[:id])
  end

  # POST /cities
  # POST /cities.xml
  def create
    @city = City.new(params[:city])

    respond_to do |format|
      if @city.save
        format.html { redirect_to(@city, :notice => 'City was successfully created.') }
        format.xml  { render :xml => @city, :status => :created, :location => @city }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cities/1
  # PUT /cities/1.xml
  def update
    @city = City.find(params[:id])

    respond_to do |format|
      if @city.update_attributes(params[:city])
        format.html { redirect_to(@city, :notice => 'City was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.xml
  def destroy
    @city = City.find(params[:id])
    @city.destroy

    respond_to do |format|
      format.html { redirect_to(cities_url) }
      format.xml  { head :ok }
    end
  end
end
