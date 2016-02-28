class Comment < ActiveRecord::Base
  belongs_to :entry, inverse_of: :comments
end
