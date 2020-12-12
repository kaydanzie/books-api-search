class ApplicationController < ActionController::API
  private

  # Can be used to validate any params required by the external API
  def validate_required_params(required_param)
    return unless request.query_parameters[required_param].blank?

    render json: { error: "'#{required_param}' query parameter is required" },
           status: :bad_request
  end
end
