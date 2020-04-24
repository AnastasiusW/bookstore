ActiveAdmin.register Order do
    permit_params :status

    scope("In Progress") { |scope| scope.where(status:[:in_progress,:in_queue,:in_delivery]) }
    scope :delivered
    scope :canceled

    index do
        selectable_column

        column :created_at
        column :status

        column :action do |order|
          link_to I18n.t('admin.orders.change_states'), admin_order_path(order)
        end
    end

    action_item :in_delivery, only: :show do
        link_to t('admin.orders.status.in_delivery'), in_delivery_admin_order_path, method: :put
      end

      action_item :delivered, only: :show do
        link_to t('admin.orders.status.delivered'), delivered_admin_order_path, method: :put
      end

      action_item :cancel, only: :show do
        link_to t('admin.orders.status.cancel'), cancel_admin_order_path, method: :put
      end

      member_action :in_delivery, method: :put do
        #order = Order.in_queue.where(id: params[:id])
        if Order.find(params[:id]).in_queue?
            order = Order.in_queue.find(params[:id])
            order.in_delivery!
            flash[:notice] = I18n.t('admin.orders.success')
            redirect_to admin_order_path(order)
        else
            flash[:alert] = I18n.t('admin.orders.fail')
        end
        redirect_to admin_orders_path
      end

      member_action :delivered, method: :put do
       # order = Order.in_delivery.where(id: params[:id])
        if Order.find(params[:id]).in_delivery?
            order = Order.in_delivery.find(params[:id])
            order.delivered!
            flash[:notice] = I18n.t('admin.orders.success')
            redirect_to admin_order_path(order)
        else
            flash[:alert] = I18n.t('admin.orders.fail')
        end
        redirect_to admin_orders_path
      end

      member_action :cancel, method: :put do
        order = Order.find(params[:id])
        order.canceled!
        redirect_to admin_order_path(order)
      end


end
