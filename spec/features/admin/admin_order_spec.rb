RSpec.describe 'Admin order' do
  let!(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
  end

  context 'when on order admin page' do
    let!(:order) { create(:order) }

    before do
      visit admin_orders_path
    end

    it 'when admin click on View button' do
      click_link(I18n.t('admin.orders.buttons.view'), match: :first)
      expect(page).to have_current_path(admin_order_path(order))
    end

    it 'when admin click on Edit button' do
      click_link(I18n.t('admin.orders.buttons.edit'), match: :first)
      expect(page).to have_current_path(edit_admin_order_path(order))
    end
  end

  describe 'when admin change states of order' do
    before do
      visit edit_admin_order_path(order)
    end

    context 'when change state to in_delivery with success' do
      let(:order) { create(:order, status: :in_queue) }

      it 'when admin change state order from in_queue to in_delivery with success' do
        select 'in_delivery', from: 'order_active_admin_requested_event'
        find_by_id('order_submit_action').click
        expect(page).to have_content(I18n.t('admin.orders.success'))
      end
    end

    context 'when change state to delivered with success' do
      let(:order) { create(:order, status:  :in_delivery) }

      it 'when admin change state order from in_delivery to delivered with success' do
        select 'delivered', from: 'order_active_admin_requested_event'
        find_by_id('order_submit_action').click
        expect(page).to have_content(I18n.t('admin.orders.success'))
      end
    end

    context 'when change state to cancel with success' do
      context 'when state in_progress' do
        let(:order) { create(:order, status: :in_progress) }

        it 'when admin change state order from in_progress to canceled with success' do
          select 'canceled', from: 'order_active_admin_requested_event'
          find_by_id('order_submit_action').click
          expect(page).to have_content(I18n.t('admin.orders.success'))
        end
      end

      context 'when state in_queue' do
        let(:order) { create(:order, status: :in_queue) }

        it 'when admin change state order from in_queue to canceled with success' do
          select 'canceled', from: 'order_active_admin_requested_event'
          find_by_id('order_submit_action').click
          expect(page).to have_content(I18n.t('admin.orders.success'))
        end
      end

      context 'when state in_delivery' do
        let(:order) { create(:order, status: :in_delivery) }

        it 'when admin change state order from in_delivery to canceled with success' do
          select 'canceled', from: 'order_active_admin_requested_event'
          find_by_id('order_submit_action').click
          expect(page).to have_content(I18n.t('admin.orders.success'))
        end
      end

      context 'when state delivered' do
        let(:order) { create(:order, status: :delivered) }

        it 'when admin change state order from delivered to canceled with success' do
          select 'canceled', from: 'order_active_admin_requested_event'
          find_by_id('order_submit_action').click
          expect(page).to have_content(I18n.t('admin.orders.success'))
        end
      end
    end
  end
end
