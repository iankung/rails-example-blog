class Article < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    validates :title, presence: true,        ##error messages are auto generated based on these conditions
                      length: {minimum: 5}   ##check and print these errors in the view files
end
