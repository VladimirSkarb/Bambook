class UserPolicy < ApplicationPolicy
  def authenticate?
    user.present?
  end

  def update?
    return true if user.present? && user == article
  end

  def destroy?
    return true if user.present? && user == article
  end

  private

  def article
    record
  end
end
