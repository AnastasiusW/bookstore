ActiveAdmin.register Book do
  permit_params :title, :description, :price, :quantity,
                :width, :height, :depth, :year, :material, :category_id, author_ids: []

  decorate_with BookDecorator

  index do
    selectable_column
    id_column
    column :category
    column :title
    column :authors, &:authors_names
    column :description do |book|
      truncate(book.description, length: Presenters::Show::DESCRIPTION_LIMIT)
    end
    column :price do |book|
      number_to_currency(book.price, unit: '€')
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :category
      row :authors, &:authors_names
      row :price
      row :quantity
      row :width
      row :height
      row :depth
      row :year
      row :material
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :category
      f.input :authors, as: :check_boxes, collection: AuthorDecorator.decorate_collection(Author.all)
      f.input :description
      f.input :year
      f.input :price
      f.input :material
      f.input :height
      f.input :width
      f.input :depth
    end
    f.actions
  end
end
