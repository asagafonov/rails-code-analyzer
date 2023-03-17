# frozen_string_literal: true

class Repository::CheckPolicy < ApplicationPolicy
  def show?
    belongs_to_user?
  end

  def create?
    user
  end

  private

  def belongs_to_user?
    record.repository.user_id == user&.id
  end
end
