class Image < ApplicationRecord
  acts_as_taggable_on :tags
  validates :url, presence: true, format: {
    with: %r/[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/,
    message: 'not a valid URL'
  }
end
