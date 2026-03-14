class FermiQuestion < ApplicationRecord
  has_many :fermi_attempts, dependent: :destroy

  CATEGORIES = %w[Population Consumption Retail/StoreCount Mobility/Transport Media/Internet B2BMarketSizing Other].freeze
  DIFFICULTIES = %w[Easy Medium Hard].freeze

  validates :title, presence: true
  validates :prompt_text, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :difficulty, presence: true, inclusion: { in: DIFFICULTIES }
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  scope :by_category, ->(cat) { where(category: cat) if cat.present? }
  scope :by_difficulty, ->(diff) { where(difficulty: diff) if diff.present? }

  private

  def generate_slug
    base = title.to_s.parameterize
    base = "q-#{Digest::MD5.hexdigest(title.to_s)[0..7]}" if base.blank?
    self.slug ||= base
  end
end
