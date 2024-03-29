# frozen_string_literal: true

module RepositoryChecksHelper
  def group_errors_by_path(errors)
    return {} if errors.empty?

    errors.each_with_object({}) do |err, acc|
      path = err&.file_path

      acc[path] ||= []
      acc[path] << { rule: err&.rule, message: err&.message, location: err&.location }
    end
  end

  def github_link(repo, path)
    _, slug = path.split("tmp/repository_checks/#{repo&.full_name}/")
    "https://github.com/#{repo&.full_name}/blob/#{repo&.default_branch}/#{slug}"
  end
end
