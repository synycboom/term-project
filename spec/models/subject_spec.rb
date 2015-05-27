require 'rails_helper'

RSpec.describe Subject, :type => :model do
  describe "add new subject validation(happy path)" do
    let(:subject) { Subject.new(s_id:"cn201",s_name:"OOP",section:"570001") }
    it "can be saved" do
        subject.should respond_to(:save)
        subject.save.should be_truthy
    end
  end
  
  describe "add new subject validation(sad path)" do
    let(:subject) { Subject.new(s_id:"cn201",s_name:"OOP",section:" ") }
    it "can not be saved" do
        subject.should respond_to(:save)
        subject.save.should be_falsey
    end
  end
end
