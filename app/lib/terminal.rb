# frozen_string_literal: true

class Terminal
  def self.run_command(command)
    output, status = Open3.popen3(command) do |_stdin, stdout, _stderr, wait_thr|
      [stdout.read, wait_thr.value.exitstatus]
    end

    return output unless status.to_i.zero?

    ''
  end
end
