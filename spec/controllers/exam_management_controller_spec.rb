require 'rails_helper'
require 'spec_helper'

RSpec.describe ExamManagementController, :type => :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #show_all_locations" do
    it "return http success" do
      get :show_all_locations
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #show_all_subjects" do
    it "return http success" do
      get :show_all_subjects
      expect(response).to have_http_status(:success)
      
    end
  end
  
  describe "#add_new_location" do
    it 'should render the add_location_form template' do
			get :add_location_form
			response.should render_template 'add_location_form'
		end
		it 'should create a new location' do
		 # double = double('Location')
     # ExamManagementController.any_instance.stub(:add_new_location).and_return(double)
      post :add_new_location, {:room_no => "503",:total_table => "40", :building => "Engineering"}
      flash[:notice].should_not be_nil
    end
  end
  
  

end
