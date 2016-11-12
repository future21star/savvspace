module Permissible
  extend ActiveSupport::Concern

  included do
    has_many :authorizations, -> { joins(:role) }, dependent: :destroy
  end

  def grant_role(role_name, authorizable=nil)
    return true if has_role?(role_name, authorizable)

    authorizations.new(role: Role.find_by(name: role_name),
                       authorizable: authorizable).save
  end

  def grant_role!(role_name, authorizable=nil)
    role = Role.find_or_create_by(name: role_name)
    grant_role(role.name, authorizable=nil)
  end

  def has_role?(role_name, authorizable=nil)
    authorizations.exists?(roles: { name: role_name }, authorizable: authorizable)
  end
end
