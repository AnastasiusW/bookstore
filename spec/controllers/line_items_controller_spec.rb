RSpec.describe LineItemsController, type: :controller do
  let(:order) { create(:order) }
  let(:book) { create(:book) }

  before do
    allow(controller).to receive(:current_order).and_return(order)
  end

  context 'with GET #index' do
    it 'when  render :index view' do
      get :index, params: { order_id: order.id }
      expect(response).to render_template :index
      expect(assigns(:presenter)).to be_a(Presenters::LineItems::Index)
    end
  end

  context 'with POST #create' do
    let(:valid_params) { { order_id: order.id, book_id: book.id, quantity: 2 } }
    let(:invalid_params) { { order_id: order.id, book_id: 'wrong', quantity: 2 } }

    it 'when line_item create with success' do
      expect { post(:create, params: valid_params) }.to change(LineItem, :count).by(1)
    end

    it 'when line_item create with fail' do
      expect { post(:create, params: invalid_params) }.to change(LineItem, :count).by(0)
      expect(flash[:alert]).to eq(I18n.t('cart_block.fail'))
    end
  end

  context 'with PUT #update' do
    let(:current_quantity) { 2 }
    let!(:line_item) { create(:line_item, order: order, quantity: current_quantity) }

    it 'when increment quantity' do
      put :update, params: { order_id: order.id, id: line_item.id, quantity_action: 'increment' }
      expect(order.line_items.find_by(id: line_item.id).quantity).to eq(current_quantity + 1)
      expect(response).to redirect_to(order_line_items_path(order.id))
      expect(response.status).to eq 302
    end

    it 'when decrement quantity' do
      put :update, params: { order_id: order.id, id: line_item.id, quantity_action: 'decrement' }
      expect(order.line_items.find_by(id: line_item.id).quantity).to eq(1)
      expect(response).to redirect_to(order_line_items_path(order.id))
      expect(response.status).to eq 302
    end
  end

  context 'with DESTROY #delete' do
    let!(:line_item) { create(:line_item, order: order) }

    it 'when destroy line_items' do
      expect { delete(:destroy, params: { order_id: order.id, id: line_item.id }) }.to change(LineItem, :count).by(-1)
      expect(response).to redirect_to(order_line_items_path(order.id))
    end
  end
end
