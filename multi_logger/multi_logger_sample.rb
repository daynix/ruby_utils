require 'logger'

# MultiIO class for the Ruby logger
class MultiIO
  def initialize(*targets)
    @targets = targets
  end

  def write(*args)
    @targets.each { |t| t.write(*args) }
  end

  def close
    @targets.each(&:close)
  end
end

def log_prefix
  caller_locations(1..1).first.label + ': '
end

# Test class for logger prefix
class TestLogger
  def initialize(log)
    log.info(log_prefix + 'This is a logger test')
  end
end

def test_logger_call_function(log)
  log.info(log_prefix + 'This is a logger test')
end

log_file = File.open('debug.log', 'a')
log = Logger.new MultiIO.new(STDOUT, log_file)

log.info(log_prefix + 'This is a logger test')

test_logger_call_function(log)

TestLogger.new(log)
