RSpec.describe Services::Checkout::Show do
  subject(:service) { described_class.new(order: order) }
  let(:order) {create(:order)}



  context 'when call :address step' do
    let(:current_step){:address}

    it { expect(service.call(current_step)).to be_a Presenters::Address}
  end

  context 'when call :delivery step' do
    let(:current_step){:delivery}
    it {expect(service.call(current_step)).to be_a Presenters::Deliveries::Show}
  end

  context 'when call :payment step' do
    let(:current_step){:payment}
    it {expect(service.call(current_step)).to be_a Presenters::Payments::Show}
  end

  context 'when call :confirm step' do
    let(:current_step){:confirm}
    let!(:order) {create(:order,:order_addresses,user: user,delivery:delivery)}
    let!(:user) {create(:user)}
    let!(:delivery) { create(:delivery) }
    let!(:credit_card) {create(:credit_card,user: user)}
    it {  expect(service.call(current_step)).to be_a CreditCard}
  end


  context 'when call :complete step' do
    let(:current_step){:complete}
    let!(:order) {create(:order,:order_addresses,user: user,step: :complete)}
    let!(:user) {create(:user)}


    it ':step is changed to finish' do
      expect(Order.find_by(id: order.id).step).to eq ("complete")
      service.call(current_step)
      expect(Order.find_by(id: order.id).step).to eq ("finish")

    end
  end
end
