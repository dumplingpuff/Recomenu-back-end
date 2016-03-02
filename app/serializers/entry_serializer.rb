class EntrySerializer < ActiveModel::Serializer
  attributes :id, :restaurant, :location, :date, :time, :dish, :content, :rating
end
