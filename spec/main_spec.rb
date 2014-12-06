require 'spec_helper'

describe Detail do

  it { should validate_presence_of :purchaser_name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :address }
  it { should validate_presence_of :merchant_name }
  it { should belong_to :user }

  it 'should calculate the total revenue from latest creation' do
	@test = Detail.create(purchaser_name: 'David Bowie', 
			  			  description: 'foam moon', 
			  			  price: 100,
			  			  amount: 2,
			  			  address: '123 Main St.',
			  			  merchant_name: 'The Labyrinth',
			  			  created_at: Time.now,
                user_id: 1)
  	expect(Detail.latest_upload_revenue).to eql 200
  	@test.delete
  end
end

describe User do

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many :details }
end