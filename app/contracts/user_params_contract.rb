class UserParamsContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:email).filled(:string)
    required(:password_digest).filled(:string)
  end

  rule(:name) do
    unless /\A\w+\z/i.match?(value)
      key.failure(I18n.t(:name_format_error, scope: 'model.errors.user.name'))
    end
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure(I18n.t(:email_format_error, scope: 'model.errors.user.email'))
    end
  end
end