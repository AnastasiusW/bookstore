require 'rails_helper'

RSpec.describe AuthorDecorator do
  subject(:decorator) { described_class.new(author) }

  let(:author) { create(:author, firstname: 'Fenimore', lastname: 'Cooper') }

  it 'will be full name' do
    expect(decorator.full_name).to eq('Fenimore Cooper')
  end
end
