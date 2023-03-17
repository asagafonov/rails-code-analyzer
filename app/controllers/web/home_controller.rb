# frozen_string_literal: true

module Web
  class HomeController < ApplicationController
    def index
      @repositories = current_user&.repositories&.all
    end
  end
end
