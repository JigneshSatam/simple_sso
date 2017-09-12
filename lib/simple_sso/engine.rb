module SimpleSso
  class Engine < ::Rails::Engine
    isolate_namespace SimpleSso

    initializer "simple_sso.draw_routes", before: :load_config_initializers do |app|
      Rails.application.routes.append do
        mount SimpleSso::Engine => "/simple_sso"
      end
    end

    initializer 'simple_sso.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        include SimpleSso::AuthenticationsHelper
        helper SimpleSso::AuthenticationsHelper
        before_action :check_authentication
        skip_before_action :check_authentication, only: [:unauthenticated]
        if SimpleSso::AuthenticationsHelper.sso_server?
          after_action :redirect_to_service_provider, if: :logged_in_user_has_service_token
          after_action :set_session_service_token, if: :has_service_token?
        end
      end
    end
  end
end
