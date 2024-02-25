class CartProductPolicy < ApplicationPolicy
  def create?
    user.present? # Allow creation if user is logged in
  end

  def update?
    user.present? && user.admin? # Only admins can update cart products
  end

  def destroy?
    user.present? && user.admin? # Only admins can delete cart products
  end

  def remove_product?
    user.present? # Allow removal if user is logged in
  end
end
