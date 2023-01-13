class User < ApplicationRecord
    acts_as_voter
    has_many :posts
end
