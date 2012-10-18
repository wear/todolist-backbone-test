require 'spec_helper'

describe "todos/index" do
  before(:each) do
    assign(:todos, [
      stub_model(Todo),
      stub_model(Todo)
    ])
  end

  it "renders a list of todos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
