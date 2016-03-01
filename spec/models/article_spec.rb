require 'rails_helper'

RSpec.describe Entry do
  describe 'associations' do
    def association
      described_class.reflect_on_association(:comments)
    end

    it 'has many comments' do
      expect(association).not_to be_nil
      expect(association.options[:inverse_of]).not_to be_nil
    end
  end
end
