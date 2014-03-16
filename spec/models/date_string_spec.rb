require 'spec_helper'

describe DateString do
  it "returns the date only when not end of month and not end of string" do
    string = DateString.new(Date.new(2014,03,01), Date.new(2014,03,05))
    expect(string).to eq("1st, ")
  end

  it "returns date,month and year when end of string" do
    string = DateString.new(Date.new(2014,03,01), Date.new(2014,03,01))
    expect(string).to eq("1st March 2014")
  end

  it "returns date and month when end of month" do
    string = DateString.new(Date.new(2014,03,31), Date.new(2014,04,02))
    expect(string).to eq("31st March, ")
  end

end
