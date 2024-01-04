class ProjectSpacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      elsif @user.organization_user?
        scope.joins(project: [:organizations_projects])
          .joins("LEFT JOIN organizations_users ON organizations_users.organization_id =
          organizations_projects.organization_id")
          .where(organizations_users: { user_id: @user.id })
      else
        scope.none
      end
    end
  end
end
