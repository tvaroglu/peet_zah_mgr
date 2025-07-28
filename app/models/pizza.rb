class Pizza < ApplicationRecord
  has_many :pizza_toppings, dependent: :destroy
  has_many :toppings, through: :pizza_toppings

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :unique_topping_set
  validate :must_have_at_least_one_topping

  before_validation :normalize_name

  private

  # Capitalize name before saving:
  def normalize_name
    self.name = name.strip.titleize if name.present?
  end

  # Prevent duplicate topping combinations (regardless of name)
  def unique_topping_set
    return if toppings.empty?

    normalized_topping_ids = toppings.map(&:id).sort

    Pizza.includes(:toppings).find_each do |existing|
      next if existing.id == id  # allow self if updating
      if existing.toppings.map(&:id).sort == normalized_topping_ids
        errors.add(:base, "A pizza with the same set of toppings already exists")
        break
      end
    end
  end

  def must_have_at_least_one_topping
    errors.add(:toppings, "must include at least one topping") if toppings.empty?
  end
end
