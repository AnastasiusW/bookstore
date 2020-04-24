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

    it 'when admin click on Change States button' do
      click_link(I18n.t('admin.orders.change_states'), match: :first)

      expect(page).to have_current_path(admin_order_path(order))
    end
  end

  describe 'when admin change states of order' do
    before do
      visit admin_order_path(order)
    end

    context 'when change state to in_delivery with success' do
      let(:order) { create(:order, status: :in_queue) }

      it 'when admin change state order from in_queue to in_delivery with success' do
        click_link(I18n.t('admin.orders.status.in_delivery'))
        expect(page).to have_content(I18n.t('admin.orders.success'))
      end
    end

    context 'when change state to in_delivery with fails' do
      let(:order) { create(:order, status: :in_progress) }

      it 'when admin change state order from in_progress to in_delivery with fail' do
        click_link(I18n.t('admin.orders.status.in_delivery'))
        expect(page).to have_content(I18n.t('admin.orders.fail'))
      end
    end

    context 'when change state to delivered with success' do
      let(:order) { create(:order, status:  :in_delivery) }

      it 'when admin change state order from in_delivery to delivered with success' do
        click_link(I18n.t('admin.orders.status.delivered'))
        expect(page).to have_content(I18n.t('admin.orders.success'))
      end
    end

    context 'when change state to delivered with fails' do
      let(:order) { create(:order, status: :in_progress) }

      it 'when admin change state order from in_progress to delivered with fail' do
        click_link(I18n.t('admin.orders.status.delivered'))
        expect(page).to have_content(I18n.t('admin.orders.fail'))
      end
    end

    context 'when change state to cancel with success' do
      context 'when state in_progress' do
        let(:order) { create(:order, status: :in_progress) }

        it 'when admin change state order from in_progress to delivered with success' do
          click_link(I18n.t('admin.orders.status.canceled'))
          expect(page).to have_content(I18n.t('admin.orders.success'))
        end
      end

      context 'when state in_queue' do
        let(:order) { create(:order, status: :in_queue) }

        it 'when admin change state order from in_progress to delivered with success' do
          click_link(I18n.t('admin.orders.status.canceled'))
          expect(page).to have_content(I18n.t('admin.orders.success'))
        end
      end

      context 'when state in_delivery' do
        let(:order) { create(:order, status: :in_delivery) }

        it 'when admin change state order from in_progress to delivered with success' do
          click_link(I18n.t('admin.orders.status.canceled'))
          expect(page).to have_content(I18n.t('admin.orders.success'))
        end
      end

      context 'when state delivered' do
        let(:order) { create(:order, status: :delivered) }

        it 'when admin change state order from in_progress to delivered with success' do
          click_link(I18n.t('admin.orders.status.canceled'))
          expect(page).to have_content(I18n.t('admin.orders.success'))
        end
      end
    end
  end
end
