class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user && (user.has_role?("author") || user.ambassadorships.any?)
  end

  def update?
    user && (user.has_role?("admin") || record.author == user)
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
