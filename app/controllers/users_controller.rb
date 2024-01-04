class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = policy_scope(User)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    result = Users::SetupNewUser.new({
      current_user: current_user,
      params: params,
      user: @user,
    }).perform

    if !result[:success]
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: result[:errors], status: :unprocessable_entity }
      end
      return
    end

    @user = result[:data]
    authorize @user

    respond_to do |format|
      if @user.save
        send_email_verification(@user)

        format.html { redirect_to edit_user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def send_email_verification(user)
      UserMailer.with(user: user).email_verification.deliver_later
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
        .permit(
          :email,
          :first_name,
          :last_name,
          :password,
          :password_confirmation,
          :phone,
          :role_id,
        )
    end
end
