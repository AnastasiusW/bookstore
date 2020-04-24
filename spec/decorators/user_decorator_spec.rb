RSpec.describe UserDecorator do
    subject(:decorator) { described_class.new(user) }
    let!(:user) {create(:user, email: 'nastya@gmail.com')}

    it 'when check name_to_avatar' do
        expect(decorator.name_to_avatar).to eq(user.email.first.capitalize)
    end
end
