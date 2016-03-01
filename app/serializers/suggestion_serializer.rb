class SuggestionSerializer < ActiveModel::Serializer
  attributes :id, :name, :restaurant, :location, :dish, :votes, :status
end
