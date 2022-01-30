class UserSerializer
  include JSONAPI::Serializer
  attributes :email
  has_many :products

  cache_options store: Rails.cache, namespace: 'json-serializer', expires_in: 1.hour
end
