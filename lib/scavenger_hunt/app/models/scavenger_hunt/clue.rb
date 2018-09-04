class ScavengerHunt::Clue < ScavengerHunt::ApplicationRecord
  after_create :create_hints
  before_save :set_position
  before_save :set_prompt

  belongs_to :game
  belongs_to :representation
  has_many :answers
  has_many :hints

  delegate :location, to: :game
  delegate :resource, to: :representation

  default_scope -> { order(:position) }
  scope :answered, -> { where.not(ended_at: nil) }
  scope :position_scope, ->(clue) { where(game_id: clue.game_id) }
  scope :unanswered, -> { where(ended_at: nil) }

  def answered?
    ended_at.present?
  end

  def first_hint
    hints.order(:used_at).first
  end

  def next
    game.clues.unanswered.where("position > ?", position).first
  end

  def prev
    game.clues.unscoped.unanswered.where("position < ?", position).order(position: :desc).first
  end

  private

  def create_hints
    representations = resource.representations.with_metum_named(ScavengerHunt::Game::HINT_METUM_NAME).approved.by_ordinality
    representations.each do |representation|
      hints.create!(clue: self, representation: representation)
    end
  end

  def set_prompt
    prompt_representation = resource.representations.with_metum_named(ScavengerHunt::Game::CLUE_PROMPT_METUM_NAME).approved.first
    self.prompt = prompt_representation.text if prompt_representation.present?
    true
  end
end