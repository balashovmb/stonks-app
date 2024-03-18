class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :result_message

  def result_message(result)
    result.success? ? { notice: result.success[:message] } : { alert: result.failure[:message] }
  end
end
