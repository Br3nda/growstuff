class Notification < ApplicationRecord
  belongs_to :sender, class_name: 'Member', inverse_of: :sent_notifications
  belongs_to :recipient, class_name: 'Member', inverse_of: :notifications
  belongs_to :item, optional: true, polymorphic: true

  validates :subject, length: { maximum: 255 }

  scope :unread, -> { where(read: false) }
  scope :by_recipient, ->(recipient) { where(recipient_id: recipient) }

  before_create :replace_blank_subject
  after_create :send_email

    def post
      return item if item_type == 'Post'
    end

  def self.unread_count
    unread.size
  end

  def replace_blank_subject
    self.subject = "(no subject)" if subject.nil? || subject =~ /^\s*$/
  end

  def send_email
    Notifier.notify(self).deliver_now! if should_send_email && recipient.send_notification_email
  end
end
