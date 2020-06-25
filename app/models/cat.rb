require 'action_view'

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    CAT_COLORS =  %w(White Black Brown Blue Yellow Green Red Pink)

    validates :birth_date, :color, :name, :sex, :description, presence: true
    validates :sex, inclusion: { in: %w(M F) }
    validates :color, inclusion: CAT_COLORS

    def age
        time_ago_in_words(self.birth_date)
    end
end
