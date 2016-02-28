class Entry < ActiveRecord::Base
  has_many :comments, inverse_of: :entry
end
