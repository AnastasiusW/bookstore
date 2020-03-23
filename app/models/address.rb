class Address < ApplicationRecord::Base
    belongs_to :addressable, polymorphic: true
end
