RSpec.describe UserAddressesController, type: :controller do
  let(:user) { create(:user, :with_addresses) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'when post billing address' do
      post :create, params: { id: user.billing_address.id, billing_address: attributes_for(:address) }
      expect(response).to redirect_to edit_user_path(user)
    end

    it 'when post shipping address' do
      post :create, params: { id: user.shipping_address.id, shipping_address: attributes_for(:address) }
      expect(response).to redirect_to edit_user_path(user)
    end
  end

  describe 'POST #create' do
    it 'when patch  billing address' do
      patch :update, params: { id: user.billing_address.id, billing_address: attributes_for(:address) }
      expect(response).to redirect_to edit_user_path(user)
    end

    it 'when patch shipping address' do
      patch :update, params: { id: user.shipping_address.id, shipping_address: attributes_for(:address) }
      expect(response).to redirect_to edit_user_path(user)
    end
  end
end
