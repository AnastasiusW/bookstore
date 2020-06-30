RSpec.describe Services::Checkout::Address::Update do
  subject(:service) { described_class.new(order: order, billing: billing_params, shipping: shipping_params, use_billing: use_billing) }

  let(:billing_params) { attributes_for(:address, type: 'billing_address') }
  let(:shipping_params) { attributes_for(:address, type: 'shipping_address') }

  describe '#Create' do
    let(:order) { create(:order) }

    context 'when create billing and shipping address' do
      let(:use_billing) { { use_billing_address: '0' } }

      it 'params is valid, use billing and shipping address' do
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address).to eq(nil)
        expect(Order.find_by(id: order.id).shipping_address).to eq(nil)
        expect(service.call).to eq(true)
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address.address).to eq(billing_params[:address])
        expect(Order.find_by(id: order.id).shipping_address.address).to eq(shipping_params[:address])
      end
    end

    context 'when create billing and shipping address, use billing for shipping address' do
      let(:use_billing) { { use_billing_address: '1' } }

      it 'params is valid, status :use_billing_address will changes' do
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address).to eq(nil)
        expect(Order.find_by(id: order.id).shipping_address).to eq(nil)
        expect(service.call).to eq(true)
        expect(Order.find_by(id: order.id).use_billing_address).to eq(true)
        expect(Order.find_by(id: order.id).billing_address.address).to eq(billing_params[:address])
        expect(Order.find_by(id: order.id).shipping_address.address).to eq(billing_params[:address])
      end
    end

    context 'when create billing and shipping address ' do
      subject(:service) { described_class.new(order: order, billing: invalid_billing_params, shipping: invalid_shipping_params, use_billing: use_billing) }

      let(:use_billing) { { use_billing_address: '0' } }

      let(:invalid_shipping_params) do
        {
          first_name: '',
          last_name: '',
          city: '',
          country: 'AF',
          address: '',
          zip: '',
          phone: '',
          type: 'shipping_address'
        }
      end
      let(:invalid_billing_params) do
        {
          first_name: '',
          last_name: '',
          city: '',
          country: 'AF',
          address: '',
          zip: '',
          phone: '',
          type: 'billing_address'
        }
      end

      it 'params is invalid, service return nil' do
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address).to eq(nil)
        expect(Order.find_by(id: order.id).shipping_address).to eq(nil)
        expect(service.call).to eq(nil)
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address).to eq(nil)
        expect(Order.find_by(id: order.id).shipping_address).to eq(nil)
      end
    end
  end

  describe '#Update' do
    let(:order) { create(:order, :order_addresses) }

    context 'when update billing and shipping address' do
      let(:use_billing) { { use_billing_address: '0' } }

      it 'params is valid, use billing and shipping address' do
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address).to eq(order.billing_address)
        expect(Order.find_by(id: order.id).shipping_address).to eq(order.shipping_address)
        expect(service.call).to eq(true)
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address.address).to eq(billing_params[:address])
        expect(Order.find_by(id: order.id).shipping_address.address).to eq(shipping_params[:address])
      end
    end

    context 'when update billing and shipping address, use billing for shipping address' do
      let(:use_billing) { { use_billing_address: '1' } }

      it 'params is valid, status :use_billing_address will changes' do
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address).to eq(order.billing_address)
        expect(Order.find_by(id: order.id).shipping_address).to eq(order.shipping_address)
        expect(service.call).to eq(true)
        expect(Order.find_by(id: order.id).use_billing_address).to eq(true)
        expect(Order.find_by(id: order.id).billing_address.address).to eq(billing_params[:address])
        expect(Order.find_by(id: order.id).shipping_address.address).to eq(billing_params[:address])
      end
    end

    context 'when update billing and shipping address ' do
      subject(:service) { described_class.new(order: order, billing: invalid_billing_params, shipping: invalid_shipping_params, use_billing: use_billing) }

      let(:use_billing) { { use_billing_address: '0' } }

      let(:invalid_shipping_params) do
        {
          first_name: '',
          last_name: '',
          city: '',
          country: 'AF',
          address: '',
          zip: '',
          phone: '',
          type: 'shipping_address'
        }
      end
      let(:invalid_billing_params) do
        {
          first_name: '',
          last_name: '',
          city: '',
          country: 'AF',
          address: '',
          zip: '',
          phone: '',
          type: 'billing_address'
        }
      end

      it 'params is invalid, service return nil, exist adresses do not changed' do
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address).to eq(order.billing_address)
        expect(Order.find_by(id: order.id).shipping_address).to eq(order.shipping_address)
        expect(service.call).to eq(nil)
        expect(Order.find_by(id: order.id).use_billing_address).to eq(false)
        expect(Order.find_by(id: order.id).billing_address).to eq(order.billing_address)
        expect(Order.find_by(id: order.id).shipping_address).to eq(order.shipping_address)
      end
    end
  end
end
