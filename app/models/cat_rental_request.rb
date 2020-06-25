class CatRentalRequest < ApplicationRecord

    validates :start_date, :end_date, :status, presence: true
    validates :status, inclusion: {in: %w(APPROVED DENIED PENDING)}
end
