# == Schema Information
#
# Table name: word_relations
#
#  id         :integer          not null, primary key
#  word_id    :integer
#  related_id :integer
#  ranking    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WordRelation < ActiveRecord::Base
  # attr_accessible :ranking, :related_id, :word_id
  belongs_to :related, :class_name => 'Word'
  belongs_to :word

  attr_accessor :original_word, :related_word
  validates :related_word, :presence => true, :on => :create

  validates :ranking, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10 }

  scope :related_to_word, lambda { |word|
    where(:id => (word.word_relations + word.related_bys).flatten.uniq.map(&:id))
  }

  before_save :catch_word

  def self.max_ranking
    10
  end

  def catch_word
    if self.related_word
      if rel_word = Word.find_by_value(self.related_word.downcase.strip)
        self.related_id = rel_word.id
      else
        self.related_id = Word.create(:value => self.related_word.downcase.strip).id
      end
    end

    if self.original_word
      if rel_word = Word.find_by_value(self.original_word.downcase.strip)
        self.word_id = rel_word.id
      else
        self.word_id = Word.create(:value => self.original_word.downcase.strip).id
      end
    end
  end
end
