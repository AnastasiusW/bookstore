RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    it 'renders :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'when newest books' do
      get :index, params: { sort_param: 'created_at_DESC' }
      expect(response).to render_template :index
    end

    it 'when price ASC' do
      get :index, params: { sort_param: 'price_asc' }
      expect(response).to render_template :index
    end

    it 'when price DESC' do
      get :index, params: { sort_param: 'price_desc' }
      expect(response).to render_template :index
    end

    it 'when title ASC' do
      get :index, params: { sort_param: 'title_asc' }
      expect(response).to render_template :index
    end

    it 'when title DESC' do
      get :index, params: { sort_param: 'title_desc' }
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:book) { create(:book) }

    it 'renders :show template' do
      get :show, params: { id: book.id }
      expect(response).to render_template :show
    end
  end
end
