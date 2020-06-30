ActiveAdmin.register Order do
  permit_params :status, :active_admin_requested_event

  scope('In Progress') { |scope| scope.where(status: %i[in_progress in_queue in_delivery]) }
  scope :delivered
  scope :canceled

  index do
    selectable_column
    column :number
    column :created_at
    column :status
    actions
  end

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    unless event.blank?
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise I18n.t('admin.orders.errors', event: event, order: order.id) unless safe_event

      order.send("#{safe_event}!")
      flash[:notice] = I18n.t('admin.orders.success')
    end
  end

  form do |f|
    f.input :status, input_html: { disabled: true }, label: I18n.t('admin.orders.label.one')
    f.input :active_admin_requested_event, label: I18n.t('admin.orders.label.two'), as: :select,
                                           collection: f.object.aasm.events(permitted: true).map(&:name)
    f.actions
  end
end
