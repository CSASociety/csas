FactoryGirl.define do
  factory :user do
    display_name "user"
    email {"#{display_name}@example.com"}
    password "!QAZxsw2"
    password_confirmation "!QAZxsw2"

    trait :confirmed do
      confirmed_at DateTime.now
    end

    trait :as_gm do
      email "gm@example.com"
      display_name 'the_GM'
    end
  end

  # This will use the User class (Admin would have been guessed)
  #factory :admin, class: User do
  #  first_name "Admin"
  #  last_name  "User"
  #  admin      true
  #end
end
