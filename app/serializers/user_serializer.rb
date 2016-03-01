#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :admin, :email # , :can_edit

  # def can_edit
  #   # defaults to current user which may be nil
  #   scope ? scope == object : false
  # end
  has_many :entries
end
