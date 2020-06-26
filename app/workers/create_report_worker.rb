class CreateReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    CreateReportService.call(user_id, self.jid)
  end
end
