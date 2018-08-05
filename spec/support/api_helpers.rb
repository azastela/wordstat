module ApiHelpers
  def json_response(response_string = nil)
    @json_response ||= JSON.parse((response_string || response.body), { symbolize_names: true })
  end
end

RSpec.configure do |config|
  config.include ApiHelpers
end
