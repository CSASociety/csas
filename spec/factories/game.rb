FactoryGirl.define do
  factory :game do
    title "Test Title"
    description "Test Description with a bit more text than the title. Maybe even some extra other stuff that I will put in later. Maybe I should do some ipsum lorem but not right now."
    link "http://example.com"
    association :image, factory: :resource

    trait :with_user do
      association :user, :factory => [:user, :confirmed]
    end
  end

  # This will use the User class (Admin would have been guessed)
  #factory :admin, class: User do
  #  first_name "Admin"
  #  last_name  "User"
  #  admin      true
  #end
end
