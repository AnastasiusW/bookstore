ActiveAdmin.register Book do
  permit_params :title, :description, :price, :quantity,
                :width, :height, :depth, :year, :material, :category_id, author_ids: [],
                book_images_attributes: %i[id book_id image _destroy]


  decorate_with BookDecorator

  index do
    selectable_column
    id_column
    column I18n.t('admin.books.image'), &:admin_image
    column :category
    column :title
    column :authors, &:authors_names
    column :description do |book|
      truncate(book.description, length: Presenters::Books::Show::DESCRIPTION_LIMIT)
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
      row I18n.t('admin.books.image'), &:admin_image
    end
  end

  form(html: { multipart: true }) do |f|
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
      f.inputs I18n.t('admin.books.upload') do
        f.has_many :book_images, allow_destroy: true do |img|
          img.input :image, as: :file, hint: f.object.book_images.present? ? image_tag("#{img.object.image.admin_img.url}") : content_tag(:span, I18n.t('admin.books.not_exist'))
        end
      end
    end
    f.actions
  end
end
