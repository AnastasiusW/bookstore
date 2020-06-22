RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user, :with_addresses) }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns to be a Presenter::Orders::Index' do
      get :index
      expect(assigns(:presenter)).to be_a(Presenters::Orders::Index)
    end
  end

  describe 'GET #show' do
    let(:book) { create(:book) }

    it 'renders :show template' do
      get :show, params: { id: book.id }
      expect(response).to render_template :show
    end

    it 'assigns  to be a Presenter::Books::Show' do
      get :show, params: { id: book.id }
      expect(assigns(:presenter_order)).to be_a(Presenters::Orders::Show)
    end
  end
end
