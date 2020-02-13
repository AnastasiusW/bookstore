require 'rails_helper'

RSpec.describe Author, type: :model do
  subject {build(:author)}

  context "it check associations" do
    it { expect(subject).to have_many(:books)}
  end

  %i[firstname lastname].each do |field|
    it { expect(subject).to validate_presence_of(field)}
  end

end
