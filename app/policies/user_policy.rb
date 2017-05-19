class UserPolicy < ApplicationPolicy
  def show?
    update?
  end

  def update?
    destroy?
  end

  def destroy?
    user &&
      (
       user == record ||
       user.role?('admin')
      )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
