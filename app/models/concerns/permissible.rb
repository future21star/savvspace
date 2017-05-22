module Permissible
  extend ActiveSupport::Concern

  included do
    has_many :authorizations, -> { joins(:role) }, dependent: :destroy
  end

  def grant_role(role_name, authorizable = nil)
    return true if role?(role_name, authorizable)

    authorizations.new(role: Role.find_or_create_by(name: role_name),
                       authorizable: authorizable).save!
  end

  def grant_role!(role_name, authorizable = nil)
    role = Role.find_or_create_by(name: role_name)
    grant_role(role.name, authorizable)
  end

  def remove_role(role_name, authorizable = nil)
    return true unless role?(role_name, authorizable)

    authorizations.find_by(role: Role.find_by(name: role_name),
                           authorizable: authorizable).destroy
  end

  def role?(role_name, authorizable = nil)
    authorizations.exists?(roles: { name: role_name },
                           authorizable: authorizable)
  end

  def role_for_what(role_name, klass = nil)
    scope = authorizations.where(roles: { name: role_name })
    scope = scope.where(authorizable_type: klass) if klass
    scope.collect(&:authorizable)
  end
end
