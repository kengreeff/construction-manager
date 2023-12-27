class ProjectPolicy < ApplicationPolicy

  def project_owner?
    @user.organization_user? && (@user.organization_ids & @record.organization_ids).present?
  end

  def show?
    admin? || project_owner?
  end

  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      elsif @user.organization_user?
        scope.joins(:organizations_projects)
          .joins("LEFT JOIN organizations_users ON organizations_users.organization_id =
          organizations_projects.organization_id")
          .where(organizations_users: { user_id: @user.id })
      end
    end
  end
end
