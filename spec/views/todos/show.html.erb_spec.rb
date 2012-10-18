require 'spec_helper'

describe "todos/show" do
  before(:each) do
    @todo = assign(:todo, stub_model(Todo))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
