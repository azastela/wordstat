class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do
    render :nothing => true, :status => :bad_request
  end
end
