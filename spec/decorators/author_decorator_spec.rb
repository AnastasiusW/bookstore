require 'rails_helper'

RSpec.describe AuthorDecorator do
    let(:author) { create(:author, firstname: 'Fenimore', lastname: 'Cooper') }
    subject(:decorator) { described_class.new(author) }


    it "it will be full name" do
       expect(decorator.full_name).to eq('Fenimore Cooper')
    end

end
