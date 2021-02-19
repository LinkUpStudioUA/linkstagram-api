# frozen_string_literal: true

require 'bcrypt'

FactoryBot.define do
  factory :account do
    sequence :username do |n|
      "user#{n}"
    end
    sequence :email do |n|
      "person#{n}@example.com"
    end
    following { 100 }
    followers { 150 }
    trait :with_description do
      description { 'Description text' }
    end

    transient do
      password { 'password' }
    end

    after(:create) do |account, evaluator|
      password = BCrypt::Password.create(
        evaluator.password, cost: BCrypt::Engine::MIN_COST
      )

      DB[:account_password_hashes].insert(
        id: account.id, password_hash: password.to_s
      )
    end
  end

  factory :post do
    description { 'Post description' }
    association :author, factory: :account
  end

  factory :like do
    post
    account
  end

  factory :comment do
    message { 'Comment' }
    association :commenter, factory: :account
    post
  end

  factory :photo do
    image_data { Helpers::TestData.image_data }
    post
  end
end
