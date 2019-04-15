module ApiBambook
  module Entities
    class RechargesEntity < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.strftime('%Y-%m-%d %H:%M') }
      expose :id
      expose :amount
      expose :status

      with_options(format_with: :iso_timestamp) do
        expose :created_at
      end
    end
  end
end
