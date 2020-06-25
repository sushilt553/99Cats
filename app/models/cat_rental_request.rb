class CatRentalRequest < ApplicationRecord

    validates :start_date, :end_date, :status, presence: true
    validates :status, inclusion: {in: %w(APPROVED DENIED PENDING)}
    validates :does_not_overlap_approved_request

    belongs_to :cat,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :Cat

    def overlapping_requests
        CatRentalRequest
            .where.not(id: self.id)
            .where(cat_id: self.cat_id)
            .where.not('start_date > :end_date OR end_date < :start_date', start_date: self.start_date, end_date: self.end_date)
    end

    def overlapping_approved_requests
        self.overlapping_requests.where(status: 'APPROVED')
    end

    def does_not_overlap_approved_request

        if !overlapping_approved_requests.empty?
            errors[:base] = "Request conflicts with existing approved request"
        end
    end
end
