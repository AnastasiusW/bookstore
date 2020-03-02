require 'rails_helper'

RSpec.describe AuthorsBook, type: :model do
  describe '#associations' do
    it { should belong_to(:author) }
    it { should belong_to(:book) }
  end
end
