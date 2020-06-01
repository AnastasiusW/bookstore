RSpec.describe QuickRegistrationsController, type: :controller do
  describe 'GET #new' do
    context 'when user is exists' do
      let(:user) { create(:user) }

      it ' user not is signed' do
        get :new
        expect(response.status).to eq(200)
        expect(response).to render_template :new
      end

      it 'user is signed and transfers it to checkout' do
        sign_in user
        get :new
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:address))
      end
    end
  end

  describe 'POST #create' do
    context 'when guest input valid params' do
      let(:email) { FFaker::Internet.email }

      it 'created  user with temporary password and redirect to checkout ' do
        expect(User.count).to eq(0)
        post :create, params: { user: { email: email } }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:address))
        expect(User.count).to eq(1)
      end

      context 'whan guest input invalid params'
      it 'do not create  user and redirect to registate controller again  ' do
        expect(User.count).to eq(0)
        post :create, params: { user: { email: nil } }
        expect(response.status).to eq(302)
        expect(response.request.flash[:alert]).not_to be_nil
        expect(response).to redirect_to(new_quick_registration_path)
        expect(User.count).to eq(0)
      end
    end
  end
end
