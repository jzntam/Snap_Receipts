class Receipt < ActiveRecord::Base
  # validates :business_name, presence: true
  validates :image, presence: true
  validates :tax_type, presence: true
  validates :total, presence: true, on: :update
  belongs_to :report

  geocoded_by :address
  after_validation :geocode


  mount_uploader :image, ImageUploader

  before_create :image_data #, :if => lambda {|r| r.image }
  before_update :set_tax, :set_sub_total, :geocode

  def image_data
    return true unless self.image.file
    e = Tesseract::Engine.new {|e|
          e.language  = :eng
          e.blacklist = '|'
        }
    my_var = e.text_for(self.image.file.file)
    first_line = my_var.lines.detect {|line| line =~ /[\w ]{5}/ }.downcase.titleize
    ocr_data = /(\b^[Tt][OoD][Tt][AaRH])\w+\s+([$]?|[$]?\s+)([\d]+.\d\d)/.match(my_var)
    tax_data = /(\b[Tt][Aa]|[Gg][Ss]|[Pp][Ss]).+\s+.([\d]*.\d\d)/.match(my_var)
    self.business_name = first_line.strip
    if ocr_data == nil
      self.total = 0
    else
      self.total = ocr_data[-1]
    end
    if self.tax_total == nil
      set_tax
    end
    set_sub_total
  end

  def set_sub_total
    self.sub_total = self.total - self.tax_total
  end

  def set_tax
    if self.tax_type == "GST"
      self.tax_total = (self.total - (self.total / 1.05)).round(2)
    elsif self.tax_type == "PST"
      self.tax_total = (self.total - (self.total / 1.07)).round(2)
    elsif self.tax_type == "GST & PST"
      self.tax_total = (self.total - (self.total / 1.12)).round(2)
    else
      self.tax_total = 0
    end
  end

  def self.to_csv(options = {})
    CSV.generate do |csv|
      csv << column_names
      all.each do |receipt|
        csv << receipt.attributes.values_at(*column_names)
      end
    end
  end

  def self.not_time(parts)
      if parts
        where.not("business_name @@ :s", s: parts )
      end
  end
  
  def self.key_search(words)
    if words
      #where("title @@ :s", s: words )
      where("business_name @@ :s", s: words )
    end
  end

   def self.time_search(time)
    if time
      #SELECT "receipts".* FROM "receipts" WHERE("created_at >= ?", time)
      where("created_at >= ?", time )
    end
  end

   def self.cat_search(house)
    if house
      #SELECT "receipts".* FROM "receipts" WHERE("created_at >= ?", time)
      where("category @@ :s", s: house )
    end
  end

end
