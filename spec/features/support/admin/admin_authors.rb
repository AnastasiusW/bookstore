class AdminAuthorsPrism < SitePrism::Page
<<<<<<< HEAD
  element :author_first_name, "input[name='author[first_name]']"
  element :author_last_name, "input[name='author[last_name]']"
  element :author_bigraphy, "textarea[name='author[biography]']"

  def create_form(author)
    author_first_name.set(author.first_name)
    author_last_name.set(author.last_name)
    author_bigraphy.set(author.biography)
    click_button('Create Author')
  end

  def edit_form(first_name, last_name, biography)
    author_first_name.set(first_name)
    author_last_name.set(last_name)
    author_bigraphy.set(biography)
    click_button('Update Author')
  end
=======
    element :author_first_name, "input[name='author[first_name]']"
    element :author_last_name, "input[name='author[last_name]']"
    element :author_bigraphy, "textarea[name='author[biography]']"

    def create_form(author)
        author_first_name.set(author.first_name)
        author_last_name.set(author.last_name)
        author_bigraphy.set(author.biography)
        click_button('Create Author')
    end

    def edit_form(first_name,last_name,biography)
        author_first_name.set(first_name)
        author_last_name.set(last_name)
        author_bigraphy.set(biography)
        click_button('Update Author')
    end
>>>>>>> Add biography author to factory bot
end
