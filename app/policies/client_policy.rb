class ClientPolicy < ApplicationPolicy

  def show?
    record.user_id == user.id
  end

  def update?
    record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end