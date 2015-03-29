require 'rails_helper'

RSpec.describe Location, :type => :model do
  describe "add new location validation(happy path)" do
    let(:location) { Location.new(room_no:"503",building:"Engineering",total_table:"40") }
    it "can be saved" do
        location.should respond_to(:save)
        location.save.should be_truthy
    end
  end
  
  describe "add new location validation(sad path)" do
    let(:location) { Location.new(room_no:"",building:"Engineering",total_table:"aaaa") }
    it "can not be saved" do
        location.should respond_to(:save)
        location.save.should be_falsey
    end
  end
  
end
