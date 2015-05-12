module CommentsHelper

  def comment_owner?(comment)
    comment.user == current_user
  end

end
