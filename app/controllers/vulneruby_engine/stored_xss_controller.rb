# frozen_string_literal: true

module VulnerubyEngine
  def index
    render('layouyts/vulneruby_engine/stored_xss/index')
  end

  def run
    # Settup the run create new user:
    @user = User.create(name: 'Kaizen')
    @user.save!
    new_comment = Comment.create(user_id: @user.id, message: params[:message])
    new_message.save!

    if @user
      response = Rack::Response.new
      response.headers['Content-Type'] = 'text/html'
      # Trigger the stored_xss by reading associated Commnets model that is
      # tainted from the user model:
      @result = @user.comments
      render('layouts/vulneruby_engine/stored_xss/run')
    end
  end
end
