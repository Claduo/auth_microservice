class SignupParamsContract < Dry::Validation::Contract
  params do
    required(:email).value(:string)
    required(:name).value(:string)
    required(:password).value(:string)
  end
end