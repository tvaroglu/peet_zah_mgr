class Topping < ApplicationRecord
  has_many :pizza_toppings, dependent: :restrict_with_error
  has_many :pizzas, through: :pizza_toppings

  before_validation :normalize_name
  before_destroy :ensure_not_in_use

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  private

  def normalize_name
    self.name = name.to_s.strip.capitalize if name.present?
  end

  def ensure_not_in_use
    if pizzas.exists?
      errors.add(:base, "Cannot delete record because dependent pizza toppings exist")
      throw(:abort)
    end
  end
end
