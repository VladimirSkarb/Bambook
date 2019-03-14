Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount ApiBambook::BaseApi => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
