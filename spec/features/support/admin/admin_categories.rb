class AdminCategoriesPrism < SitePrism::Page
    element :element_category_title, "input[name='category[title]']"


    def create_form(category)
        element_category_title.set(category.title)
        click_button('Create Category')
    end

    def edit_form(title)
         element_category_title.set(title)
         click_button('Update Category')
    end



end
