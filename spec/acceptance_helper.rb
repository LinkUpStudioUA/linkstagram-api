require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:html, :json]
  config.request_body_formatter = proc do |params|
    JSON.pretty_generate(params)
  end
  config.response_body_formatter = Proc.new { |response_content_type, response_body| response_body }
  config.request_headers_to_include = %w[Content-Type Accept]
  config.response_headers_to_include = %w[Content-Type]

  config.curl_host = 'http://localhost:3000'
  config.api_name = "Linkstagram API"

  # config.define_group :linkstagram do |config|
  #   config.docs_dir = Rails.root.join("public", "assets", "api", "linkstagram")
  #   config.filter = :linkstagram
  # end
end
