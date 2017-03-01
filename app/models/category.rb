class Category < ActiveRecord::Base

  has_many :products
  has_attached_file :image, :styles =>{:medium => "200x200>"}


  PRICE = /\A\d+(?:\.\d{0,2})?\z/i

  validates :name, :presence => true,
  :length => {:within => 3..100}

  validates :description, :presence => true,
  :length => {:within => 3..250}

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }

end
