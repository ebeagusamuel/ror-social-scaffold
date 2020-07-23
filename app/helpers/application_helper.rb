module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def sent_requests(id)
    a = FriendRequest.exists?(user_id: current_user.id, friend_id: id)
    b = FriendRequest.exists?(user_id: id, friend_id: current_user.id)
    a || b
  end

  def current_user_requests(id)
    current_user.friend_requests.exists?(friend_id: id)
  end

  def pending_requests(id)
    request = current_user.friends.find_by(user_id: id)
    request.nil? ? true : false
  end

  def pending_invitations
    FriendRequest.where(friend_id: current_user.id).map { |frnd| frnd.user unless frnd.confirmed }.compact
  end

  def index_friendship_status(id, user)
    if sent_requests(id)
      if pending_requests(id)
        val = '<span class="profile-link">Pending</span>'.html_safe
        unless current_user_requests(id)
          val += link_to('accept', user_accept_path(user), method: :post, class: 'invite-btn')
          val += link_to('reject', user_reject_path(user), method: :post, class: 'invite-btn')
        end
        val
      else
        '<span class="profile-link">Friend</span>'.html_safe
      end
    else
      link_to('invite to friendship', user_invite_path(user), class: 'invite-btn', method: :post)
    end
  end

  def show_friendship_status(user)
    return if user == current_user

    if current_user_requests(user.id)
      '<span class="user-link">pending</span>'.html_safe
    elsif !pending_requests(user.id)
      '<span class="user-link">Friend</span>'.html_safe
    else
      link_to('invite to friendship', user_invite_path(user), class: 'invite-btn', method: :post)
    end
  end
end
