class PawnGame < ApplicationRecord
  serialize :history, coder: JSON

  validates :colour, inclusion: { in: %w[WHITE BLACK] }, allow_nil: true
  validates :facing, inclusion: { in: %w[EAST WEST NORTH SOUTH] }, allow_nil: true

  def placed?
    xpos.present? && ypos.present?
  end

  def add_log(message)
    self.history ||= []
    self.history << { message:, timestamp: Time.now }
  end

  def reset!
    update!(xpos: nil, ypos: nil, facing: nil, colour: nil, history: [])
  end
end
