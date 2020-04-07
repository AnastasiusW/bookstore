class AdminAuthorsPrism < SitePrism::Page
    element :author_first_name, "input[name='author[first_name]']"
    element :author_last_name, "input[name='author[last_name]']"

    def create_form(author)
        author_first_name.set(author.first_name)
        author_last_name.set(author.last_name)
        click_button('Create Author')
    end

    def edit_form(first_name,last_name)
        author_first_name.set(first_name)
        author_last_name.set(last_name)
        click_button('Update Author')
    end
end
