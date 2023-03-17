# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    belongs_to_user?
  end

  def new?
    user
  end

  def create?
    user
  end

  private

  def belongs_to_user?
    record.user_id == user&.id
  end
end
