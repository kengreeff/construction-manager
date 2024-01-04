class ClientPolicy < ApplicationPolicy

  def index?
    organization_user?
  end

  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      elsif @user.organization_user?
        scope.joins(:organization)
          .where(organizations: { id: @user.organization_ids })
      else
        scope.none
      end
    end
  end
end
