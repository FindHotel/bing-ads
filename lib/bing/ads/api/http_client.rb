module Bing
  module Ads
    module API
      # Bing::Ads::API::HttpClient
      class HttpClient
        API_CALL_RETRY_COUNT = 3

        def self.download(url, retry_count = API_CALL_RETRY_COUNT)
          1.upto(retry_count + 1) do |retry_index|
            http = Net::HTTP.new(URI(url))
            http.use_ssl = true
            http.ssl_version = :TLSv1
            http.ciphers = ['RC4-SHA']
            http.get(uri.request_uri)
            response = http.get_response(URI(url))
            if response.is_a?(Net::HTTPSuccess)
              break response.body
            else
              next if retry_index <= retry_count
              raise Bing::Ads::API::Errors::DownloadError, "#{response.code} #{response.msg}"
            end
          end
        end
      end
    end
  end
end
