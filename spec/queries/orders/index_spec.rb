RSpec.describe Queries::Orders::Index do
  subject(:service) { described_class.new(sort_param: sort_by, user: user) }
  let(:user){create(:user)}

  let!(:order_with_status_in_queue) {create(:order,user:user, status: :in_queue)}
  let!(:order_with_status_in_delivery) {create(:order,user:user, status: :in_delivery)}
  let!(:order_with_status_delivered) {create(:order,user:user, status: :delivered)}
  let!(:order_with_status_canceled) {create(:order,user:user, status: :canceled)}
  let!(:order_with_status_in_progress) {create(:order,user:user)}



  context 'when params sort_by == :in_queue' do
    let(:sort_by) {:in_queue}
    it 'return order with status in_queue' do
      expect(service.call).to eq([order_with_status_in_queue])
    end

  end
  context 'when params sort_by == :in_delivery' do
    let(:sort_by) {:in_delivery}
    it 'return order with status in_delivery' do

      expect(service.call).to eq([order_with_status_in_delivery])
    end

  end
  context 'when params sort_by == :delivered' do
    let(:sort_by) {:delivered}
    it 'return order with status delivered' do

      expect(service.call).to eq([order_with_status_delivered])
    end

  end

  context 'when params sort_by == :canceled' do
    let(:sort_by) {:canceled}
    it 'return order with status canceled' do

      expect(service.call).to eq([order_with_status_canceled])
    end

  end

  context 'when params sort_by == :in_progress' do
    let(:sort_by) {:in_progress}
    it 'return order with status in_queue, because in_queue is default' do

      expect(service.call).to eq([order_with_status_in_queue])
    end

  end

end
