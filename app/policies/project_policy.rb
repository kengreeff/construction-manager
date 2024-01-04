class ProjectPolicy < ApplicationPolicy

  def project_owner?
    organization_user? && (@user.organization_ids & @record.organization_ids).present?
  end

  def project_client?
    client_user? && (@user.client_ids & @record.master_project.client_ids).present?
  end

  def show?
    admin? || project_owner? || project_client?
  end

  def create?
    project_owner?
  end

  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      elsif @user.client_user?
        scope.joins(:clients_projects)
          .joins("LEFT JOIN clients_users ON clients_users.client_id =
          clients_projects.client_id")
          .where(clients_users: { user_id: @user.id })
      elsif @user.organization_user?
        scope.joins(:organizations_projects)
          .joins("LEFT JOIN organizations_users ON organizations_users.organization_id =
          organizations_projects.organization_id")
          .where(organizations_users: { user_id: @user.id })
      end
    end
  end
end
