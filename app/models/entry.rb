class Entry < ActiveRecord::Base
  # has_many :comments, inverse_of: :entry
  belongs_to :user, inverse_of: :entries, class_name: 'User'
end
