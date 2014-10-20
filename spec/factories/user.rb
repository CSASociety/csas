FactoryGirl.define do
  factory :user do
    email "user@example.com"
    display_name "user"
    password "!QAZxsw2"
    password_confirmation "!QAZxsw2"
  end

  # This will use the User class (Admin would have been guessed)
  #factory :admin, class: User do
  #  first_name "Admin"
  #  last_name  "User"
  #  admin      true
  #end
end
