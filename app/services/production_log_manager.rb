class ProductionLogManager
  LOG_DIR = Rails.root.join("log").to_s

  class << self
    def write_attack(payload)
      return unless Rails.env.production?

      attack.info(compact_payload(payload))
    end

    private

    def attack
      @attack ||= build_attack_logger
    end

    def build_attack_logger
      FileUtils.mkdir_p(LOG_DIR)
      path = File.join(LOG_DIR, "production_attack.log")
      logger = Logger.new(path, "weekly", 12)
      logger.formatter = proc do |severity, datetime, _progname, msg|
        "[#{datetime.utc.iso8601}] #{severity}: #{msg}\n"
      end
      logger
    end

    def compact_payload(payload)
      payload.is_a?(Hash) ? payload.to_json : payload.to_s
    end
  end
end
