class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    user_owns_record
  end

  def create?
    user_owns_record
  end

  def new?
    create?
  end

  def update?
    user_owns_record
  end

  def edit?
    update?
  end

  def destroy?
    user_owns_record
  end

  def user_owns_record
    record.user_id == user.id
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end
  end
end

