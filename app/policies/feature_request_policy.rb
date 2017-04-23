class FeatureRequestPolicy < ApplicationPolicy
  def index?
    user.has_role?("admin")
  end

  def show?
    user && (record.user == user || user.has_role?("admin"))
  end

  def create?
    ! user.nil?
  end

  def update?
    show?
  end

  def destroy?
    update?
  end
end
