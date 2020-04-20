RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #edit' do
    it 'when renders edit page' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end

    it 'when assigns to be a Presenters::Address' do
      get :edit, params: { id: user.id }
      expect(assigns(:presenter)).to be_a(Presenters::Address)
    end
  end

  describe 'PUT #update' do
    let(:new_password) { '111111' }

    it 'when update email' do
      put :update, params: { id: user.id, user: { email: user.email } }
      expect(response).to redirect_to root_path
    end

    it 'when update password' do
      put :update, params: { id: user.id, user: { current_password: user.password, password: new_password, password_confirmation: new_password } }
      expect(response).to redirect_to root_path
    end
  end

  describe 'DELETE #destroy' do
    it 'when destroys user' do
      delete :destroy, params: { id: user.id }
      expect(User.count).to eq(0)
      expect(response).to redirect_to root_path
    end
  end
end
