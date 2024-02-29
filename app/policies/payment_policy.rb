class PaymentPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    user.admin? || record.order.user == user
  end

  def new?
    user.present?
  end

  def create?
    user.admin? || record.order.user == user
  end

  def update?
    user.admin? || record.order.user == user
  end

  def destroy?
    user.admin? || record.order.user == user
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(order_id: user.orders.pluck(:id))
      end
    end
  end
end
