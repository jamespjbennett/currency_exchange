class ApplicationController < ActionController::API
  before_action :do_this_before_all_actions

  private
  def do_this_before_all_actions
    if !request.path.include?('api/v1')
      redirect_to api_v1_currencies_path
    end
  end
end
