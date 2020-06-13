RSpec.describe CreditCardForm, type: :model do
  context 'when presence validations' do
    it { is_expected.to validate_presence_of(:card_name) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to validate_presence_of(:user_id) }
  end



  context 'when input valid data' do
    let(:valid_params) { attributes_for(:credit_card) }
    let!(:user) {create(:user)}
    it { is_expected.to allow_value(valid_params[:card_name]).for(:card_name) }
    it { is_expected.to allow_value(valid_params[:number]).for(:number) }
    it { is_expected.to allow_value(valid_params[:cvv]).for(:cvv) }
    it { is_expected.to allow_value(valid_params[:expiration_date]).for(:expiration_date) }
    it { is_expected.to allow_value(user.id).for(:user_id) }
  end

  context 'when input invalid data' do
    let(:invalid_card_name) { '!!!!!' }
    let(:invalid_number) { FFaker::Lorem.word }
    let(:invalid_cvv) { rand(10) }
    let(:invalid_expiration_date) { FFaker::Lorem.word}
    let(:invalid_user){FFaker::Lorem.word}

    it { is_expected.not_to allow_value(invalid_card_name).for(:card_name) }
    it { is_expected.not_to allow_value(invalid_number).for(:number) }
    it { is_expected.not_to allow_value(invalid_cvv).for(:cvv) }
    it { is_expected.not_to allow_value(invalid_expiration_date).for(:expiration_date) }
    it { is_expected.not_to allow_value(invalid_user).for(:user_id) }
  end

  context 'when save form' do
    let!(:card_params) { attributes_for(:credit_card, user_id: user.id) }
    let!(:user) { create(:user) }

    let!(:credit_card_form) { described_class.new(card_params) }

    it 'when review save with success' do
      expect(CreditCard.count).to eq(0)
      credit_card_form.save(user)
      expect(CreditCard.count).to eq(1)
    end

    it 'when review save with fail' do
      expect(CreditCard.count).to eq(0)
      allow(credit_card_form).to receive(:valid?).and_return(false)
      credit_card_form.save(user)
      expect(CreditCard.count).to eq(0)
    end
  end
end
