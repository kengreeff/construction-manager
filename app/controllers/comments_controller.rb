class CommentsController < ApplicationController

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to params.dig(:comment, :redirect_path), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
        format.turbo_stream {
          render(
            turbo_stream: turbo_stream.append(
              "#{@comment.record_type}-#{@comment.record_id}-comments",
              partial: 'comments/comment',
              locals: { comment: @comment },
            )
          )
        }
      else
        format.html { redirect_to params.dig(:comment, :redirect_path), status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def comment_params
      params.fetch(:comment, {})
        .permit(
          :body,
          :record_id,
          :record_type,
          :user_id,
        )
    end
end
