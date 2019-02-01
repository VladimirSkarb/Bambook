Rails.application.routes.draw do
  mount ApiBambook::Base => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
