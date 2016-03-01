#
class User < ActiveRecord::Base
  include Authentication
  has_many :entries, inverse_of: :user, foreign_key: 'user_id'
end
