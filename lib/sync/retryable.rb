module Retryable
  RETRY_CONFIG = {
    max_attempts: 5,
    base_delay: 2
  }

  def with_retries(operation:)
    attempts = 0
    begin
      attempts += 1
      yield
    rescue => e
      if attempts < RETRY_CONFIG[:max_attempts]
        delay = RETRY_CONFIG[:base_delay] * attempts
        logger.warn "#{operation} failed, attempt #{attempts}/#{RETRY_CONFIG[:max_attempts]}. Retrying in #{delay}s..."
        sleep(delay)

        retry
      end

      logger.error "#{operation} failed after #{RETRY_CONFIG[:max_attempts]} attempts: #{e.message}"
      nil
    end
  end
end
