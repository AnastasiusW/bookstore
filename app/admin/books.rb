ActiveAdmin.register Book do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

   permit_params :title, :description, :price, :quantity,
                 :width, :height, :depth, :year, :material, :category_id, author_ids: []




end
