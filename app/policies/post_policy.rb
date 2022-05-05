# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def update?
    return false if user.nil?

    record.creator == user
  end

  def destroy?
    record.creator == user
  end
end
