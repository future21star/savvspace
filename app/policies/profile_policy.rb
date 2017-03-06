class ProfilePolicy < ApplicationPolicy
  def update?
    user &&
      (
       user == record.profiled ||
       user.has_role?("owner", record) ||
       user.has_role?("admin")
       )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
