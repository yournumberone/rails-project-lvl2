# frozen_string_literal: true

class PostCommentPolicy < ApplicationPolicy
  def destroy?
    record.user == user
  end
end
