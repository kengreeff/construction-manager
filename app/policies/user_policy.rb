class UserPolicy < ApplicationPolicy
  
  def create?
    return false if !organization_user?

    # Client User
    if @record.role == Role.find_by(key: "user")
      user_client_organization_ids = @record.clients.map { |c| c.organization_id }
      return (@user.organization_ids & user_client_organization_ids).present?
    end

    # Organization User
    if @record.role == Role.find_by(key: "organization_user")
      return (@user.organization_ids & @record.organization_ids).present?
    end
  end

  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      elsif @user.organization_user?
        scope.joins(:organizations_users)
          .where(organizations_users: { organization_id: @user.organization_ids })
      end
    end
  end

end
