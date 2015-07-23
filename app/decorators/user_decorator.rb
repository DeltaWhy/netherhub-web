class UserDecorator < Draper::Decorator
  delegate_all

  def avatar(size = 180)
    return h.image_tag "https://minotar.net/helm/#{minecraft_username}/#{size}.png", class: "avatar", width: size, height: size
  end

  def friend_actions(user = h.current_user)
    if user == model
      ""
    elsif user.friends.include? model
      h.content_tag 'span', class: 'label round success fi-torsos' do
        ' Friends'
      end
    elsif user.sent_friend_requests.where(friend_id: model.id).present?
      h.content_tag 'span', class: 'label round info fi-mail' do
        ' Friend Request Sent'
      end
    elsif user.received_friend_requests.where(user_id: model.id).present?
      h.link_to '#' do
        h.content_tag 'span', class: 'label round warning fi-plus' do
          ' Accept Friend Request'
        end
      end
    else
      h.link_to '#' do
        h.content_tag 'span', class: 'label round secondary fi-plus' do
          ' Add Friend'
        end
      end
    end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
