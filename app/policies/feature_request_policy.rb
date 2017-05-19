class FeatureRequestPolicy < ApplicationPolicy
  def index?
    user.role?('admin')
  end

  def show?
    user && (record.user == user || user.role?('admin'))
  end

  def create?
    !user.nil?
  end

  def update?
    show?
  end

  def destroy?
    update?
  end
end
