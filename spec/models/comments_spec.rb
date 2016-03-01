require 'rails_helper'

RSpec.describe Comment do
  describe 'associations to entry' do
    def association_entry
      described_class.reflect_on_association(:entry)
    end

    it 'belongs to an entry' do
      expect(association_entry).to_not be_nil
      expect(association_entry.options[:inverse_of]).to_not be_nil
    end
  end
end
