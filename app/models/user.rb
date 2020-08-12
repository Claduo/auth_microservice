class User < Sequel::Model
  plugin :association_dependencies
  plugin :secure_password, include_validations: false

  one_to_many :sessions, class: :UserSession
  add_association_dependencies sessions: :delete

  def validate
    super

    result = UserParamsContract.new.call(values)
    result.errors.each do |key, messages|
      messages.each do |message|
        errors.add(key, message)
      end
    end
  end
end
