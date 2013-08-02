# == Schema Information
#
# Table name: areas
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  parent_id         :integer
#  sub_area_url      :text
#  host_url          :text
#  atype             :string(255)
#  location_group_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Area < ActiveRecord::Base

  attr_accessible :name, :atype, :location_group
  # attr_accessible :name, :parent_id, :sub_areas_url
  has_many :areas, :foreign_key => 'parent_id', :dependent => :destroy
  belongs_to :parent, :class_name => 'Area'
  belongs_to :location_group

  scope :country_scope, where(:atype => 'country')
  scope :continent_scope, where(:atype => 'continent')
  scope :global_scope, where(:atype => 'global')

  def is_continent?
    self.atype == 'continent'
  end

  def is_country?
    self.atype == 'country'
  end

  def is_global?
    self.atype == 'global'
  end

  def get_matching_ids
    if self.try(:is_continent?)
      return [Area.global_scope.first.id, self.id, self.areas.map(&:id)].flatten.uniq
    elsif self.try(:is_country?)
      return [self.all_parents, self.id].flatten.uniq
    else
      self.id
    end
  end

  def all_include_areas
    rs = [self.id, self.areas.select("id, parent_id").collect {|a| a.all_include_areas}].flatten.uniq
    rs = rs + self.all_parents
    rs.flatten.uniq
  end

  def all_parents
    if self.parent
      [self.parent.id, self.parent.all_parents].flatten.uniq
    else
      []
    end
  end

  def fetch_sub_areas
    # RestClient.proxy = "http://127.0.0.1:8011/"

    begin
      response = RestClient.get(self.hosturl + self.sub_areas_url)
    rescue
    end

    (response || '').to_s.scan(/<a class="link" href="(.+)">(.+)<\/a>/) do |url, name|
      area = Area.create(:hosturl => self.hosturl, :name => name, :sub_areas_url => (url || ''), :parent_id => self.name == 'Global' ? nil : self.id)

      if area.level? == 1
        area.fetch_sub_areas
      end
    end
  end

  def rel_to_areas url, dry=false
    begin
      response = RestClient.get(url)
    rescue
      puts 'no response'
    end

    # puts "about to scan url: #{url}"
    # puts "total: #{(response || '').to_s.scan(/<a class="link" href="(.{1,100}\.aspx)">(.{1,100})<\/a>/).size}"

    (response || '').to_s.scan(/<a class="link" href="(.{1,130}\.aspx)">(.{1,120})<\/a>/) do |url, name|

      sub_area = Area.find_by_name(name)
      # puts "#{name}: #{url}"
      if sub_area
        sub_area.parent = self
        sub_area.save unless dry
        puts "Find & rel #{name}"
      else
        puts "Can not find #{name}"
      end
    end
  end

  def level?
    self.parent.nil? ? 1 : self.parent.level? + 1
  end
end
