class ApiCodes
  def self.code_attr(name, value)
    @attrs ||= {}
    @attrs[name] = value
    define_singleton_method name do
      @attrs[name]
    end
  end

  # ERROR CODES
  code_attr :validation_errors, 'VALIDATION_ERRORS'
  code_attr :invalid_or_missing_auth, 'INVALID_OR_MISSING_AUTH'
  code_attr :invalid_credentials, 'INVALID_CREDENTIALS'
  code_attr :something_went_wrong, 'SOMETHING_WENT_WRONG'
  code_attr :not_found, 'NOT_FOUND'
  code_attr :access_denied, 'ACCESS_DENIED'

  # SUCCESS CODES
  code_attr :success, 'SUCCESS'
  code_attr :created, 'CREATED'
  code_attr :updated, 'UPDATED'
  code_attr :deleted, 'DELETED'
end
