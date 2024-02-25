class ProductPolicy < ApplicationPolicy
  def create?
    user.admin?  # Only admin users can create products
  end

  def edit?
    user.admin?  # Only admin users can edit products
  end


  def add_to_cart?
    user.customer?  # Only customer users can add products to the cart
  end

  def remove_from_cart?
    user.customer?  # Only customer users can remove products from the cart
  end


end
