# frozen_string_literal: true

class LeadData < ApplicationRecord
  belongs_to :message, inverse_of: :lead_data, optional: true
end
