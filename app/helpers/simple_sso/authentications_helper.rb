module SimpleSso
  module AuthenticationsHelper
    module ClassMethods

    end

    module InstanceMethods
      def check_authentication
        unless logged_in?
          ErrorPrinter.print_error("Sorry, you need to login before continuing.", "Login required.")
          flash[:alert] = "Sorry, you need to login before continuing."
          if AuthenticationsHelper.sso_server?
            return redirect_to unauthenticated_path, status: 302
          else
            return redirect_to_sso
          end
        end
      end

      def redirect_to_sso
        token = Token.encode_jwt_token({service_url: ENV["MY_URL"] + "/simple_sso/authentications/login"}, ENV.fetch("EXPIRE_AFTER_SECONDS") { 1.hour })
        redirect_to (ENV["SSO_URL"] + "?service_token=" + token) and return
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods

      if sso_server?
        receiver.send :include, SimpleSso::IdentityProvider::Login
        receiver.send :include, SimpleSso::IdentityProvider::Logout
      else
        receiver.send :include, SimpleSso::ServiceProvider::Login
        receiver.send :include, SimpleSso::ServiceProvider::Logout
      end
    end

    def self.sso_server?
      return @sso_server if @sso_server
      if Rails.configuration.sso_settings["sso_server"].present? && Rails.configuration.sso_settings["sso_server"].to_s == "true"
        @sso_server = true
      else
        ErrorPrinter.print_error("This application is initialized as sso_client, if you wish to change it to sso_server change the sso_server key in simple_sso_settings.yml to true file eg: `sso_server: true`")
        @sso_server = false
      end
      return @sso_server
    end
  end
end
