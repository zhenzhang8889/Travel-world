# == Schema Information
#
# Table name: words
#
#  id         :integer          not null, primary key
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Word < ActiveRecord::Base
  # attr_accessible :value

  has_many :word_relations, :dependent => :destroy
  has_many :related_bys, :class_name => 'WordRelation', :foreign_key => 'related_id', :dependent => :destroy

  validates :value, :uniqueness => true

  before_validation :treat_value
  def treat_value
    self.value = self.value.downcase.strip if self.value
  end

  def self.get_from_real_word word
    Word.find_by_value((word || '').downcase.strip)
  end

  def self.expend_with_relationship array=[]
    rs = array.collect do |keyword| 
      if word = Word.find_by_value(keyword.to_s.try(:downcase).try(:strip))
        word.word_relations.map(&:related).map(&:value) + word.related_bys.map(&:word).map(&:value)
      else
        []
      end
    end
    # puts array.to_json
    # puts rs.flaten.uniq.to_json
    (array + rs.flatten.uniq).map(&:to_s)
  end
end
