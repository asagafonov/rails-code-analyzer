# frozen_string_literal: true

class Repository::CheckPolicy < ApplicationPolicy
  def show?
    current_user?
  end

  def create?
    user
  end

  private

  def current_user?
    record.repository.user_id == user&.id
  end
end
