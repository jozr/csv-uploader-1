require 'spec_helper'

describe Detail do

  it { should validate_presence_of :purchaser_name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :address }
  it { should validate_presence_of :merchant_name }
  
end