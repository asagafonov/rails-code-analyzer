# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    current_user?
  end

  def new?
    user
  end

  def create?
    current_user?
  end

  private

  def current_user?
    record.user_id == user&.id
  end
end
