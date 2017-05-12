class People < ActiveRecord::Base
  include Obscure

  has_one :waiver,foreign_key: 'person_id'
  belongs_to :family

  scope :find_by_obscure_id, lambda { |obscure_id|
    People.find self.unobscure_id(obscure_id)
  }

  def diet_and_allergy_complete?
    if !self.vegetarian? && !self.vegan? && !self.pescetarian? && !self.gluten_free? && !self.lactose_free? && !self.no_dietary_issues?
      return false
    end
    if !self.no_allergies? && self.allergies.blank?
      return false
    end

    true
  end

  def dietary_restrictions?
    if self.vegetarian? || self.vegan? || self.pescetarian? || self.gluten_free? || self.lactose_free?
      return true
    end
    unless self.allergies.blank?
      return true
    end

    false
  end

  def volunteer?
    if self.volunteer_meal_captain? || self.volunteer_campfire_leader? || self.volunteer_cascade_head? ||
        self.volunteer_mud_mucking? || self.volunteer_crafts? || self.volunteer_sand_castles?
      return true
    end

    false
  end

end
