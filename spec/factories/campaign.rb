FactoryGirl.define do
  factory :campaign do
    title "Test Title"
    description "Test Description with a bit more text than the title. Maybe even some extra other stuff that I will put in later. Maybe I should do some ipsum lorem but not right now."
    link "http://example.com"
    association :image, factory: :resource

    trait :with_gm do
      association :gm, :factory => [:user, :as_gm, :confirmed]
    end

    trait :with_game do
      association :game, :factory => [:game]
    end

  end
end
