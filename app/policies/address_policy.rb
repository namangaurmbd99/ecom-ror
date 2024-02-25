class AddressPolicy < ApplicationPolicy
  def new?
    user.present? # Allow all logged-in users to create new addresses
  end

  def create?
    new? # Use the same permission as for 'new' action
  end

  def show?
    user.customer? # Only customers can view addresses
  end

  def edit?
    user.customer? # Only customers can edit addresses
  end

  def update?
    edit? # Use the same permission as for 'edit' action
  end

  def destroy?
    edit? # Use the same permission as for 'edit' action
  end
end
