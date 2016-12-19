class ObservationSerializer < ActiveModel::Serializer
  attributes :time, :temperature, :pressure, :humidity
end
