class UserSession < Sequel::Model
  plugin :uuid
  many_to_one :user
end