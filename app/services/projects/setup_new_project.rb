module Projects
  class SetupNewProject

    def initialize(params = {})
      raise ArgumentError.new("Current User not supplied.") if !params[:current_user] || !params[:current_user].is_a?(User)
      raise ArgumentError.new("Project not supplied.") if !params[:project] || !params[:project].is_a?(Project)

      @current_user = params[:current_user]
      @project = params[:project]
    end

    def perform
      @project = assign_organization(@project, @current_user)

      if @project.is_master
        @project = setup_sub_project(@project)
      end

      return { success: true, data: @project }
    end

    private

      def assign_organization(project, current_user)
        project.organization_ids = current_user.organization_ids&.first
        return project
      end

      def setup_sub_project(project)
        sub_project = Project.new(
          is_master: false,
          parent_project: project,
          title: "Main Dwelling",
        )

        result = Projects::SetupNewProject.new({
          current_user: @current_user,
          project: sub_project,
        }).perform

        if result[:success]
          project.sub_projects << result[:data]
        end

        return project
      end

  end
end