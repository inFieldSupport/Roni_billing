FactoryBot.define do
    factory :user do 
      user_type {"Admin"}
      user_rate {23}
      registered_users {10}
      active_users {5}
      month {"January"}
      year {2023}
    end
  end