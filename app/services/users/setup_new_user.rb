module Users
  class SetupNewUser

    def initialize(params = {})
      raise ArgumentError.new("Current User not supplied.") if !params[:current_user] || !params[:current_user].is_a?(User)
      raise ArgumentError.new("User not supplied.") if !params[:user] || !params[:user].is_a?(User)

      @current_user = params[:current_user]
      @params = params[:params] || {}
      @user = params[:user]
    end

    def perform
      if @user.role == Role.find_by(key: "admin")
        return { success: false, errors: ["Cannot create admins."] }
      end

      @user = assign_client(@user, @params)
      @user = assign_organization(@user, @params)

      return { success: true, data: @user }
    end

    private

      def assign_client(user, params)
        if (client_id = params.dig(:user, :client_id)) && client_id.present?
          user.clients << Client.find_by(id: client_id)
        end

        return user
      end

      def assign_organization(user, params)
        # Supplied
        if (organization_id = params.dig(:user, :organization_id)) && organization_id.present?
          user.organizations << Organization.find_by(id: organization_id)
        end

        return user
      end

      def send_email_verification(user)
        UserMailer.with(user: user).email_verification.deliver_later
      end

  end
end
