class ApplicationService
  include Rails.application.routes.url_helpers

  def self.execute(*args, &block)
    new(*args, &block).execute
  end
end