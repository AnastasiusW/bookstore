class ReviewPrism < SitePrism::Page
    element :review_name_title, "input[name='review[title]']"
    element :review_name_comment, "textarea[name='review[comment]']"
    element :review_button, "#saveReview"

   def fill_in_review_form_valid_data(rating:, title:, comment:)
    find("#rating_id_#{rating}").click
    review_name_title.set(title)
    review_name_comment.set(comment)
    review_button.click
    end


   def fill_in_review_form_invalid_data( title:, comment:)
    review_name_title.set(title)
    review_name_comment.set(comment)
    review_button.click
    end


end
