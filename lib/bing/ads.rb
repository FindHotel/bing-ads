require 'active_support/core_ext/string/inflections'
require 'persey'
require 'savon'

require 'bing/ads/api/errors'
require 'bing/ads/api/soap_client'
require 'bing/ads/api/v11'
require 'bing/ads/api/v11/config'
require 'bing/ads/api/v11/services'

require 'bing/ads/utils'
require 'bing/ads/version'

module Bing
  module Ads
    # A Ruby client for Bing Ads API that includes a proxy to all
    # Bing Ads API web services and abstracts low level details of
    # authentication with OAuth.
  end
end
