Sequel.seed(:development) do
  def run
    [['user_1', 'user_1@test_mail.com', 'user_toor'],
     ['user_10', 'user_10@test_mail.com', 'user_toor'],
     ['user_11', 'user_11@test_mail.com', 'user_toor'],
     ['user_101', 'user_101@test_mail.com', 'user_toor']
    ].each do |name, email, password|
      User.create(name: name, email: email, password: password)
    end
  end
end