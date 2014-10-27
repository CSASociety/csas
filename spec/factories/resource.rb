include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :resource do
    file { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
  end
end
