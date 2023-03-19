# frozen_string_literal: true

module RepositoryChecksHelper
  def self.group_errors_by_path(errors)
    return {} if errors.empty?

    errors.each_with_object({}) do |err, acc|
      path = err&.file_path

      acc[path] ||= []
      acc[path] << { rule: err&.rule, message: err&.message, location: err&.location }
    end
  end

  def self.github_path(repo, path)
    "https://github.com/#{repo&.full_name}/blob/#{repo&.default_branch}/#{path.split('/')[4..].join('/')}"
  end
end
