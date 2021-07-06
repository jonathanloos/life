class User < ApplicationRecord
    has_many :events

    def name
        first_name + ' ' + last_name
    end
end
