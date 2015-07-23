class UserDecorator < Draper::Decorator
  delegate_all

  def avatar(size = 180)
    return h.image_tag "https://minotar.net/helm/#{minecraft_username}/#{size}.png", class: "avatar", width: size, height: size, alt: minecraft_username
  end

  def friend_status(user = h.current_user)
    if user == model
      :self
    elsif user.friends.include? model
      :friend
    elsif user.sent_friend_requests.where(friend_id: model.id).present?
      :sent_request
    elsif user.received_friend_requests.where(user_id: model.id).present?
      :received_request
    else
      nil
    end
  end

  def friend_actions(user = h.current_user)
    case friend_status(user)
    when :self
    when :friend
      h.content_tag 'span', class: 'label round success fi-torsos' do
        ' Friends'
      end
    when :sent_request
      h.content_tag 'span', class: 'label round info fi-mail' do
        ' Friend Request Sent'
      end
    when :received_request
      h.link_to h.accept_request_user_path(model), method: :post do
        h.content_tag 'span', class: 'label round warning fi-plus' do
          ' Accept Friend Request'
        end
      end
    else
      h.link_to h.friend_request_user_path(model), method: :post do
        h.content_tag 'span', class: 'label round secondary fi-plus' do
          ' Add Friend'
        end
      end
    end
  end

  def friend_button(user = h.current_user)
    case friend_status(user)
    when :self
    when :friend
      h.content_tag 'span', class: 'button round success fi-torsos' do
        ' Friends'
      end
    when :sent_request
      h.content_tag 'span', class: 'button round info fi-mail' do
        ' Friend Request Sent'
      end
    when :received_request
      h.link_to h.accept_request_user_path(model), method: :post do
        h.content_tag 'span', class: 'button round warning fi-plus' do
          ' Accept Friend Request'
        end
      end
    else
      h.link_to h.friend_request_user_path(model), method: :post do
        h.content_tag 'span', class: 'button round secondary fi-plus' do
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
