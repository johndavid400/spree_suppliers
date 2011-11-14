require "spec_helper"

describe CitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/cities").should route_to("cities#index")
    end

    it "routes to #new" do
      get("/cities/new").should route_to("cities#new")
    end

    it "routes to #show" do
      get("/cities/1").should route_to("cities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cities/1/edit").should route_to("cities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cities").should route_to("cities#create")
    end

    it "routes to #update" do
      put("/cities/1").should route_to("cities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cities/1").should route_to("cities#destroy", :id => "1")
    end

  end
end
