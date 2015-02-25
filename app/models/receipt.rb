class Receipt < ActiveRecord::Base
  # validates :business_name, presence: true
  validates :image, presence: true
  validates :tax_type, presence: true

  mount_uploader :image, ImageUploader
  belongs_to :report

  before_create :image_data #, :if => lambda {|r| r.image }

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
    self.total = ocr_data[-1]
    if self.tax_total == nil
      set_tax
    end
    self.sub_total = self.total - self.tax_total
  end

  def set_tax
    if self.tax_type == "GST"
      self.tax_total = (self.total - (self.total / 1.05))
    elsif self.tax_type == "PST"
      self.tax_total = (self.total - (self.total / 1.07))
    elsif self.tax_type == "GST & PST"
      self.tax_total = (self.total - (self.total / 1.12))
    else
      self.tax_total = 0
    end
  end

end
