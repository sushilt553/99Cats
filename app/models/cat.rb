require 'action_view'

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    CAT_COLORS =  %w(White Black Brown Blue Yellow Green Red Pink)

    validates :birth_date, :color, :name, :sex, :description, presence: true
    validates :sex, inclusion: { in: %w(M F) }
    validates :color, inclusion: CAT_COLORS

    has_many :cat_rental_requests,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :CatRentalRequest,
        dependent: :destroy

    belongs_to :owner,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    def age
        time_ago_in_words(self.birth_date)
    end
end
