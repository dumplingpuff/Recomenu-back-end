#
class UserLoginSerializer < ActiveModel::Serializer
  attributes :id, :email, :token, :admin
end
