Rails.application.routes.draw do
  mount ApiBambook::BaseApi => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
