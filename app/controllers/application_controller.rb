class ApplicationController < ActionController::API
  protected

  rescue_from ArgumentError do |e|
    render :json => {"ErrorType" => "Validation Error", "message" => e.message},
           :code => :bad_request
  end
end
