class JobSerializer < ActiveModel::Serializer
  attributes :id, :url, :html, :server_code, :completed
end
