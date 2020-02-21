require 'rails_helper'

RSpec.describe Category, type: :model do
  it { expect(build(:category)).to validate_presence_of(:title) }
  it { expect(build(:category)).to have_many(:books) }
end
