class Order < ApplicationRecord
belongs_to :user, optional: true
enum status: {
    in_progress: 1,
    in_queue: 2,
    in_delivery: 3,
    delivered: 4,
    canceled: 5
}

end
