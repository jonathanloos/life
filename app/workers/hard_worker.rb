class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    logger.info "HARD WORKER"
  end
end
