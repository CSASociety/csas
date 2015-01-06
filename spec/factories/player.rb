FactoryGirl.define do
  factory :player do
    association :user, :factory => [:user, :confirmed]
    association :campaign, :factory => [:campaign, :with_game, :with_gm]
    after_build do |player|
      status_approver_id player.user.id
    end

    trait :approved do
      status "active"
    end


    trait :gm_inited do
      after_build do | player |
        status_approver_id player.campaign.gm.id
      end
    end
  end

end
