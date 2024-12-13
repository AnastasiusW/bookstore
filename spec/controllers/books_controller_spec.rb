RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    it 'renders :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns to be a Presenter::Books' do
      get :index
      expect(assigns(:presenter)).to be_a(Presenters::Books::Index)
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
      expect(assigns(:presenter_book)).to be_a(Presenters::Books::Show)
    end
  end
end
