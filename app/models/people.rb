class People < ActiveRecord::Base

  belongs_to :family

  def diet_and_allergy_complete?
    if !self.vegetarian? && !self.vegan? && !self.pescetarian? && !self.gluten_free? && !self.lactose_free? && !self.no_dietary_issues?
      return false
    end
    if !self.no_allergies? && self.allergies.blank?
      return false
    end

    true
  end

end
