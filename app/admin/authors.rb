ActiveAdmin.register Author do
  #actions :all, except: :destroy
   permit_params :first_name, :last_name, :biography
   remove_filter :authors_books
   #config.remove_action_item(:destroy)


   index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :biography
    column I18n.t('admin.authors.view') do |author|
      link_to I18n.t('admin.authors.view'), admin_author_path(author)
    end
    column I18n.t('admin.authors.edit') do |author|
      link_to I18n.t('admin.authors.edit'), edit_admin_author_path(author)
    end
    column I18n.t('active_admin.delete') do |author|
      link_to I18n.t('active_admin.delete'), admin_author_path(author),
              method: :delete, data: { confirm: t('admin.authors.confirmations', quantity: author.books.count) }
   end
  end
end
