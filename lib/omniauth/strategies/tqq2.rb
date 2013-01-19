require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Tqq2 < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "tqq2"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site           => "https://open.t.qq.com",
        :authorize_url  => "/cgi-bin/oauth2/authorize",
        :token_url      => "/cgi-bin/oauth2/access_token"
      }
      option :token_params, {
        :parse          => :query
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid {
        raw_info["name"]
      }

      info do
        {
          :name        => raw_info['name'],
          :nickname    => raw_info['nick'],
          :email       => raw_info['email'],
          :location    => raw_info['location'],
          :image       => raw_info['head'],
          :description => raw_info['introduction']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      credentials do
        hash = {'token' => access_token.token}
        hash.merge!('openid' => @openid) if @openid
        hash.merge!('openkey' => @openkey) if @openkey
        hash.merge!('refresh_token' => access_token.refresh_token) if access_token.expires? && access_token.refresh_token
        hash.merge!('expires_at' => access_token.expires_at) if access_token.expires?
        hash.merge!('expires' => access_token.expires?)
        hash
      end

      def callback_phase
        # 伪造防csrf的state，腾讯微博NMMP
        request.params['state'] = session['omniauth.state']
        @openid = request.params["openid"]
        @openkey = request.params["openkey"]
        super
      end

      def raw_info
        @raw_info ||= access_token.get("/api/user/info", params: {
          openid: @openid,
          oauth_consumer_key: access_token.client.id,
          access_token: access_token.token,
          oauth_version: '2.a'
        }, parse: :json).parsed["data"]
      end
    end
  end
end


OmniAuth.config.add_camelization('tqq2', 'Tqq2')