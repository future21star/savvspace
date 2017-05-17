class AreaPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user && user.role?('admin')
  end

  def update?
    create?
  end

  def destroy?
    update?
  end
end
