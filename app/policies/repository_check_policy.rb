# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def show?
    current_user?
  end

  def create?
    user
  end

  private

  def current_user?
    record.user_id == user&.id
  end
end
