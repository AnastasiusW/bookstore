RSpec.describe LineItemsController, type: :controller do
  let!(:user_one) {create(:user)}
  let!(:user_two) {create(:user)}
  let!(:order_one) {create(:order,user: user_one)}
  let!(:order_two) {create(:order, user:user_two)}
  let!(:order_guest) {create(:order)}

  describe 'with DESTROY #delete' do
    let!(:line_item_one) {create(:line_item,order: order_one)}
    let!(:line_item_two) {create(:line_item, order: order_two)}
    let!(:line_item_guest) {create(:line_item, order: order_guest)}
    context 'when user_one  is signed' do
      before do
        session['order_id'] = order_one.id
        sign_in user_one
      end

      it 'user is signed and cannot destroy line_items of another`s user' do
        expect(LineItem.count).to eq(3)
        expect(LineItem.find_by(id:line_item_two)).to eq(line_item_two)
        delete  :destroy, params: { order_id: order_two.id, id: line_item_two.id }
        expect(LineItem.count).to eq(3)
        expect(LineItem.find_by(id:line_item_two)).to eq(line_item_two)
      end


      it 'user is signed and cannot destroy guest`s line_item' do
        expect(LineItem.count).to eq(3)
        expect(LineItem.find_by(id:line_item_guest)).to eq(line_item_guest)
        delete  :destroy, params: { order_id: order_guest.id, id: line_item_guest.id }
        expect(LineItem.find_by(id:line_item_guest)).to eq(line_item_guest)
        expect(LineItem.count).to eq(3)

      end

      it 'user is signed and can destroy only own line_items' do
        expect(LineItem.count).to eq(3)
        expect(LineItem.find_by(id:line_item_one)).to eq(line_item_one)
        delete  :destroy, params: { order_id: order_one.id, id: line_item_one.id }
        expect(LineItem.count).to eq(2)
        expect(LineItem.find_by(id:line_item_one)).to eq(nil)
      end
    end

    context 'when guest order' do
      before do
        session['order_id'] = order_guest.id
      end
      it 'guest can destroy only own line_items' do
        expect(LineItem.count).to eq(3)
        expect(LineItem.find_by(id:line_item_guest)).to eq(line_item_guest)
        delete  :destroy, params: { order_id: order_guest.id, id: line_item_guest.id }
        expect(LineItem.count).to eq(2)
        expect(LineItem.find_by(id:line_item_guest)).to eq(nil)
      end

      it 'guest can not destroy another`s line_items' do
        expect(LineItem.count).to eq(3)
        expect(LineItem.find_by(id:line_item_one)).to eq(line_item_one)
        delete  :destroy, params: { order_id: order_one.id, id: line_item_one.id }
        expect(LineItem.count).to eq(3)
        expect(LineItem.find_by(id:line_item_one)).to eq(line_item_one)
      end

  end


end



  describe 'with GET #index' do

    context 'when user is signed ' do
      before  do
        session['order_id'] = order_one.id
        sign_in user_one
      end
        it 'when  render :index view' do
          get :index, params: { order_id: order_one.id }
          expect(response).to render_template :index
          expect(assigns(:presenter)).to be_a(Presenters::LineItems::Index)
        end
    end

    context 'when guest' do
      before  do
        session['order_id'] = order_guest.id
      end
        it 'when  render :index view' do
          get :index, params: { order_id: order_guest.id }
          expect(response).to render_template :index
          expect(assigns(:presenter)).to be_a(Presenters::LineItems::Index)
        end
    end
  end

  describe 'with POST #create' do
  let!(:book) { create(:book) }
  context 'when user is signed ' do
      before  do
        session['order_id'] = order_one.id
        sign_in user_one
      end
    let(:valid_params) { { order_id: order_one.id, book_id: book.id, quantity: 2 } }
    let(:invalid_params_book) { { order_id: order_one.id, book_id: 'wrong', quantity: 2 } }


    it 'user is signed and create line_item with success in own order' do
      expect { post(:create, params: valid_params) }.to change(LineItem, :count).by(1)
    end

    it 'user is signed and can not create line_item with wrong book_id' do
      expect { post(:create, params: invalid_params_book) }.to change(LineItem, :count).by(0)
      expect(flash[:alert]).to eq(I18n.t('cart_block.fail'))
    end
  end
  context 'when guest ' do
    before  do
      session['order_id'] = order_guest.id

    end
  let(:valid_params) { { order_id: order_guest.id, book_id: book.id, quantity: 2 } }
  let(:invalid_params_book) { { order_id: order_guest.id, book_id: 'wrong', quantity: 2 } }


  it 'guest create line_item with success in own order' do
    expect { post(:create, params: valid_params) }.to change(LineItem, :count).by(1)
  end

  it 'guest can not create line_item with wrong book_id' do
    expect { post(:create, params: invalid_params_book) }.to change(LineItem, :count).by(0)
    expect(flash[:alert]).to eq(I18n.t('cart_block.fail'))
  end
end
  end

  describe 'with PUT #update' do

  let!(:book) { create(:book) }

    let(:current_quantity) { 2 }
    let!(:line_item_one) { create(:line_item, order: order_one, quantity: current_quantity) }
    let!(:line_item_two) { create(:line_item, order: order_two, quantity: current_quantity) }

    let!(:line_item_guest) { create(:line_item, order: order_guest, quantity: current_quantity) }
    context 'when user_one is signed' do
      before  do
        session['order_id'] = order_one.id
        sign_in user_one
      end

      it 'user is signed and try change quantity with empty quantity_action' do
        put :update, params: {order_id: order_one, id: line_item_one, quantity_action: ""}
        expect(flash[:alert]).to eq(I18n.t('cart_block.item_fail_update'))
        expect(response).to redirect_to(order_line_items_path(order_one.id))
        expect(response.status).to eq 302
      end
      it 'user is signed and  increment quantity of own line_item' do
        put :update, params: { order_id: order_one.id, id: line_item_one.id, quantity_action: 'increment' }
        expect(order_one.line_items.find_by(id: line_item_one.id).quantity).to eq(current_quantity + 1)
        expect(response).to redirect_to(order_line_items_path(order_one.id))
        expect(response.status).to eq 302
      end
      it 'user is signed and can not increment quantity of another`s line_item' do
        put :update, params: { order_id: order_two.id, id: line_item_two.id, quantity_action: 'increment' }
        expect(order_two.line_items.find_by(id: line_item_two.id).quantity).to eq(current_quantity)
      end

      it 'user is signed and  decrement quantity of own line_item' do
        put :update, params: { order_id: order_one.id, id: line_item_one.id, quantity_action: 'decrement' }
        expect(order_one.line_items.find_by(id: line_item_one.id).quantity).to eq(1)
        expect(response).to redirect_to(order_line_items_path(order_one.id))
        expect(response.status).to eq 302
      end

      it 'user is signed and can not decrement quantity of another`s line_item' do
        put :update, params: { order_id: order_two.id, id: line_item_two.id, quantity_action: 'increment' }
        expect(order_two.line_items.find_by(id: line_item_two.id).quantity).to eq(current_quantity)
      end
  end

  context 'when guest' do
    before  do
      session['order_id'] = order_guest.id

    end
    it 'guest have order and can increment quantity of own line_item' do
      put :update, params: { order_id: order_guest.id, id: line_item_guest.id, quantity_action: 'increment' }
      expect(order_guest.line_items.find_by(id: line_item_guest.id).quantity).to eq(current_quantity + 1)
      expect(response).to redirect_to(order_line_items_path(order_guest.id))
      expect(response.status).to eq 302
    end
    it 'guest have order and can not increment quantity of another`s line_item' do
      put :update, params: { order_id: order_one.id, id: line_item_one.id, quantity_action: 'increment' }
      expect(order_one.line_items.find_by(id: line_item_one.id).quantity).to eq(current_quantity)
    end

    it 'guest have order and can decrement quantity of own line_item' do
      put :update, params: { order_id: order_guest.id, id: line_item_guest.id, quantity_action: 'decrement' }
      expect(order_guest.line_items.find_by(id: line_item_guest.id).quantity).to eq(1)
      expect(response).to redirect_to(order_line_items_path(order_guest.id))
      expect(response.status).to eq 302
    end

    it 'user is signed and can not decrement quantity of another`s line_item' do
      put :update, params: { order_id: order_one.id, id: line_item_one.id, quantity_action: 'increment' }
      expect(order_one.line_items.find_by(id: line_item_one.id).quantity).to eq(current_quantity)
    end
end
end

end
