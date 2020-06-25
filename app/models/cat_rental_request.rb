class CatRentalRequest < ApplicationRecord

    validates :start_date, :end_date, :status, presence: true
    validates :status, inclusion: {in: %w(APPROVED DENIED PENDING)}

    belongs_to :cat,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :Cat
end
