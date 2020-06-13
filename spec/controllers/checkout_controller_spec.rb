RSpec.describe CheckoutController, type: :controller do

let(:user) {create(:user)}


before do
  sign_in user
  session['order_id'] = order.id
end

  describe 'Show' do
      context 'when address step, order status :step = address' do
      let(:order) {create(:order,:with_line_items,user:user)}

        it 'show address template, because params step address' do
          get :show, params: {id: :address}
          expect(response.status).to eq(200)
          expect(response).to render_template :address
        end

        it 'can not show template of step higher current status step' do
          get :show, params: {id: :confirm}
          expect(response.status).to eq(302)
          expect(response).not_to render_template :confirm
        end
      end


      context 'when delivery step,order status :step = delivery' do
        let(:order) {create(:order,:with_line_items,user:user, step: :delivery)}

          it 'show delivery template,because params step is delivery' do
            get :show, params: {id: :delivery}
            expect(response.status).to eq(200)
            expect(response).to render_template :delivery
          end

          it ' can not show template of step higher current status step' do
            get :show, params: {id: :confirm}
            expect(response.status).to eq(302)
            expect(response).not_to render_template :confirm
          end
      end

      context 'when delivery step, order status :step = address ' do
        let(:order) {create(:order,:with_line_items,user:user)}

          it 'render previous step, because status of order step is not delivery' do
            get :show, params: {id: :delivery}
            expect(response.status).to eq(302)
            expect(response).to redirect_to(checkout_path(:address))
          end
      end

      context 'when payment step, order status :step = payment ' do
        let(:order) {create(:order,:with_line_items,user:user, step: :payment)}
        it 'show payment template, because params step is payment' do
          get :show, params: {id: :payment}
          expect(response.status).to eq(200)
          expect(response).to render_template :payment
        end

        it ' can not show template of step higher current status step' do
          get :show, params: {id: :confirm}
          expect(response.status).to eq(302)
          expect(response).not_to render_template :confirm
        end

      end

      context 'when payment step, order status :step = delivery ' do
        let(:order) {create(:order,:with_line_items,user:user, step: :delivery)}
        it 'render previous step, because status of order step is delivery' do
          get :show, params: {id: :payment}
          expect(response.status).to eq(302)
          expect(response).to redirect_to(checkout_path(:delivery))
        end
      end


      context 'when confirm step, order status :step = confirm' do
        let(:order) {create(:order,:with_line_items,:order_addresses,user:user, step: :confirm)}
        it 'show confirm template, because params step is confirm' do
          get :show, params: {id: :confirm}
          expect(response.status).to eq(200)
          expect(response).to render_template :confirm
        end

        it 'can not show template of step higher current status step' do
          get :show, params: {id: :complete}
          expect(response.status).to eq(302)
          expect(response).not_to render_template :complete
        end
      end

      context 'when confirm step, order status :step = confirm' do
        let(:order) {create(:order,:with_line_items,:order_addresses,user:user, step: :payment)}
        it 'render previous step, because status of order step is payment' do

          get :show, params: {id: :confirm}
          expect(response.status).to eq(302)
          expect(response).to redirect_to(checkout_path(:payment))

        end
      end

  context 'when complete step, order status :step = confirm' do
    let(:order) {create(:order,:with_line_items,:order_addresses,user:user, step: :complete)}
    it 'show complete template,because params step is complete' do
      expect(Order.find_by(id: order.id).status).to eq("in_progress")
      expect(Order.find_by(id: order.id).step).to eq("complete")
      get :show, params: {id: :complete}
      expect(response.status).to eq(200)
      expect(response).to render_template :complete
      expect(Order.find_by(id: order.id).status).to eq("in_queue")
      expect(Order.find_by(id: order.id).step).to eq("finish")
    end
  end

  context 'when complete step,order status :step = confirm' do
    let(:order) {create(:order,:with_line_items,:order_addresses,user:user, step: :confirm)}
    it 'render previous step, because status of order step is confirm' do
      get :show, params: {id: :complete}
      expect(response.status).to eq(302)
      expect(response).to redirect_to(checkout_path(:confirm))
      end
    end
  end


  describe 'Update' do
    let(:user) {create(:user,:with_addresses)}

    context 'when update address, order status :step = :address' do

      let(:order) {create(:order,:with_line_items,user:user)}
      let(:billing_params){
        {
        first_name: user.billing_address.first_name,
        last_name: user.billing_address.last_name,
        city: user.billing_address.city,
        country: user.billing_address.country,
        address: user.billing_address.address,
        zip: user.billing_address.zip,
        phone: user.billing_address.phone,
        type: 'billing_address'
      }}

      let(:shipping_params){
        {
        first_name: user.shipping_address.first_name,
        last_name: user.shipping_address.last_name,
        city: user.shipping_address.city,
        country: user.shipping_address.country,
        address: user.shipping_address.address,
        zip: user.shipping_address.zip,
        phone: user.shipping_address.phone,
        type: 'shipping_address'
    }}

      let(:invalid_shipping_params){
        {
        first_name: "",
        last_name: "",
        city: "",
        country: "AF",
        address: "",
        zip: "",
        phone: "",
        type: 'shipping_address'
    }}
      let(:invalid_billing_params){
        {
        first_name: "",
        last_name: "",
        city: "",
        country: "AF",
        address: "",
        zip: "",
        phone: "",
        type: 'billing_address'
      }}

    it 'user`s billing and shipping addresses are exist and use for order, :step status is changed' do
      expect(Order.find_by(id: order.id).step).to eq("address")
      put :update, params: {id: :address, order:{billing: billing_params, shipping: shipping_params, use_billing_address: "0"}}
      expect(Order.find_by(id: order.id).step).to eq("delivery")
      expect(response.status).to eq(302)
      expect(response).to redirect_to(checkout_path(:delivery))
     end

     it 'user`s billing  address is exists, use billing address for shipping, :step status is changed' do
      expect(Order.find_by(id: order.id).step).to eq("address")
      put :update, params: {id: :address, order:{billing: billing_params,shipping: invalid_shipping_params, use_billing_address: "1"}}
      expect(Order.find_by(id: order.id).step).to eq("delivery")
      expect(response.status).to eq(302)
      expect(response).to redirect_to(checkout_path(:delivery))
     end

     it 'input invalid params for billing and shipping address, :step status do not changed' do
      expect(Order.find_by(id: order.id).step).to eq("address")
      put :update, params: {id: :address, order:{billing: invalid_billing_params,shipping: invalid_shipping_params, use_billing_address: "0"}}
      expect(Order.find_by(id: order.id).step).to eq("address")
      expect(response.status).to eq(302)
      expect(response).to redirect_to(checkout_path(:address))
     end
    end

    context 'when update address, order status :step = :payment' do

      let(:order) {create(:order,:with_line_items,user:user, step: :payment)}
      let(:billing_params){
        {
        first_name: user.billing_address.first_name,
        last_name: user.billing_address.last_name,
        city: user.billing_address.city,
        country: user.billing_address.country,
        address: user.billing_address.address,
        zip: user.billing_address.zip,
        phone: user.billing_address.phone,
        type: 'billing_address'
      }}

      let(:shipping_params){
        {
        first_name: user.shipping_address.first_name,
        last_name: user.shipping_address.last_name,
        city: user.shipping_address.city,
        country: user.shipping_address.country,
        address: user.shipping_address.address,
        zip: user.shipping_address.zip,
        phone: user.shipping_address.phone,
        type: 'shipping_address'
    }}

    it 'order that have :step status higher than current step can return to previous step, :step will not change' do
      expect(Order.find_by(id: order.id).step).to eq("payment")
      put :update, params: {id: :address, order:{billing: billing_params, shipping: shipping_params, use_billing_address: "0"}}
      expect(Order.find_by(id: order.id).step).to eq("payment")
      expect(response.status).to eq(302)
      expect(response).to redirect_to(checkout_path(:delivery))
     end
    end



    context 'when update delivery, order status :step = delivery' do
      let(:delivery) {create(:delivery)}
      let(:order) {create(:order,:with_line_items,user:user, step: :delivery)}
      it 'input valid params changed, :step status is changed' do
        expect(Order.find_by(id: order.id).step).to eq("delivery")
        put :update, params: {id: :delivery, order:{delivery_id: delivery.id}}
        expect(Order.find_by(id: order.id).step).to eq("payment")
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:payment))
       end

       it 'input invalid params changed, :step status is changed' do
        expect(Order.find_by(id: order.id).step).to eq("delivery")
        put :update, params: {id: :delivery, order:{delivery_id: ""}}
        expect(Order.find_by(id: order.id).step).to eq("delivery")
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:delivery))
       end

    end


    context 'when update delivery, order status :step = confirm ' do
      let(:delivery) {create(:delivery)}
      let(:order) {create(:order,:with_line_items,user:user, step: :confirm)}
      it 'order that have :step status higher than current step can return to previous step, :step will not change' do
        expect(Order.find_by(id: order.id).step).to eq("confirm")
        put :update, params: {id: :delivery, order:{delivery_id: delivery.id}}
        expect(Order.find_by(id: order.id).step).to eq("confirm")
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:payment))
       end
    end


    context 'when update payment,order status :step = payment' do
      let(:card) {create(:credit_card)}

      let(:payment_params) { attributes_for(:credit_card, user_id: user.id)}
      let(:order) {create(:order,:with_line_items, user:user, step: :payment)}
      let(:invalid_card_params){
      {user_id: '',
       cvv: '',
       number: '',
       card_name: '',
       expiration_date:''
        }
      }

      it 'input valid params changed, :step status is changed' do
        expect(Order.find_by(id: order.id).step).to eq("payment")
        put :update, params: {id: :payment, order:{payment: payment_params}}
        expect(Order.find_by(id: order.id).step).to eq("confirm")
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:confirm))
       end

       it 'input invalid params changed, :step status is changed' do
        expect(Order.find_by(id: order.id).step).to eq("payment")
        put :update, params: {id: :payment, order:{payment: invalid_card_params}}
        expect(Order.find_by(id: order.id).step).to eq("payment")
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:payment))
       end

    end


    context 'when update payment, order status :step = complete' do
      let(:card) {create(:credit_card)}
      let (:payment_params) {attributes_for(:credit_card).merge(user_id: user.id)}
      let(:order) {create(:order,:with_line_items, user:user, step: :complete)}
      let(:invalid_card_params){
      {user_id: '',
       cvv: '',
       number: '',
       card_name: '',
       expiration_date:''
        }
      }

      it 'order that have :step status higher than current step can return to previous step, :step will not change' do
        expect(Order.find_by(id: order.id).step).to eq("complete")
        put :update, params: {id: :payment, order:{payment: payment_params}}
        expect(Order.find_by(id: order.id).step).to eq("complete")
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:confirm))
       end
    end

    context 'when update confirm, order status :step = comfirm' do
      let(:order) {create(:order,:with_line_items, user:user, step: :confirm)}

      it 'input valid params changed, :step status is changed' do
        expect(Order.find_by(id: order.id).step).to eq("confirm")
        put :update, params: {id: :confirm}
        expect(Order.find_by(id: order.id).step).to eq("complete")
        expect(response.status).to eq(302)
        expect(response).to redirect_to(checkout_path(:complete))
       end
    end

  end

end
