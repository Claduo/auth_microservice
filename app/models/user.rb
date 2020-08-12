class User < Sequel::Model
  plugin :association_dependencies
  plugin :secure_password, include_validations: false

  NAME_FORMAT = %r{\A\w+\z}

  one_to_many :sessions, class: :UserSession
  add_association_dependencies sessions: :delete

end
