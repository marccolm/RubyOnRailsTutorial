require 'rubygems'
require 'ap'

require 'irb/completion'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

module Readline
  module History
    LOG = "#{ENV['HOME']}/.irb-history"

    def self.write_log(line)
      File.open(LOG, 'ab') {|f| f << "#{line}\n"}
    end

    def self.start_session_log
      write_log("\n# session start: #{Time.now}\n\n")
      at_exit { write_log("\n# session stop: #{Time.now}\n") }
    end
  end

  alias :old_readline :readline
  def readline(*args)
    ln = old_readline(*args)
    begin
      History.write_log(ln)
    rescue
    end
    ln
  end
end

IRB::Irb.class_eval do
  def output_value
    ap @context.last_value
  end
end

Readline::History.start_session_log

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT_MODE] = false
require 'irb/completion'
