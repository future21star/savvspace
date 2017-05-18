class ProfilePolicy < ApplicationPolicy
  def update?
    user &&
      (
       user == record.profiled ||
       user.role?('owner', record.profiled) ||
       user.role?('admin')
      )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
