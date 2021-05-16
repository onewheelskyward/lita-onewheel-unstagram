require 'rest-client'

module Lita
  module Handlers
    class OnewheelUnstagram < Handler
      route /.*(https:\/\/www.instagram.com\/p\/.*)\?/i, :handle_unstagram

      def handle_unstagram(response)
        fetch_url = response.matches[0][0]
        Lita.logger.info("Fetching #{fetch_url}")

        resp = RestClient.get(fetch_url, user_agent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0')
        quick_down = fetch_url

        if m = /window._sharedData = ({.*})\;/.match(resp)
          json = JSON.parse m[1]
          Lita.logger.info json['entry_data']
          Lita.logger.info json['entry_data']['PostPage']
          Lita.logger.info json['entry_data']['PostPage'][0]
          Lita.logger.info json['entry_data']['PostPage'][0]['graphql']
          Lita.logger.info json['entry_data']['PostPage'][0]['graphql']['shortcode_media']
          quick_down += " #{json['entry_data']['PostPage'][0]['graphql']['shortcode_media']['display_url']}"
        end

        response.reply quick_down
      end

      Lita.register_handler(self)
    end
  end
end
