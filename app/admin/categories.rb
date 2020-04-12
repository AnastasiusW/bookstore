ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column
    column :title
    column I18n.t('admin.categories.view') do |category|
      link_to I18n.t('admin.categories.view'), admin_category_path(category)
    end
    column I18n.t('admin.authors.edit') do |category|
      link_to I18n.t('admin.categories.edit'), edit_admin_category_path(category)
    end
    column I18n.t('active_admin.delete') do |category|
      link_to I18n.t('active_admin.delete'), admin_category_path(category),
              method: :delete, data: { confirm: t('admin.categories.confirmations', quantity: category.books.count) }
    end
  end
end
