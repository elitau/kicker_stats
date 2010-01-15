class TwitterClient
  
  
  # alle methoden da drin sind klassenmethoden (viele wege führen nach rom)
  class <<self
    def update(status_message)
      begin
        twitter_gateway.update(status_message)
      # TODO: Check out the type of exception and catch this!
      rescue Exception => e
        "Error"
      end
    end
    
    private
      def oauth
        @oauth ||= Twitter::OAuth.new(ConfigFu.config.consumer_key, ConfigFu.config.consumer_secret)
      end

      def authorized_oauth
        oauth.authorize_from_access(ConfigFu.config.access_token, ConfigFu.config.access_secret)
        @authorized_oauth = oauth
      end

      def twitter_gateway
        @twitter_gateway ||= Twitter::Base.new(authorized_oauth)
      end
  end
  
  
  
end