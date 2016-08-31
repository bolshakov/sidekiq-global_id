# frozen_string_literal: true
require 'globalid'
require 'active_job/arguments'

module Sidekiq
  # Sidekiq and GlobalId integration
  module GlobalId
    autoload :Arguments, 'sidekiq/global_id/arguments'
    autoload :ClientMiddleware, 'sidekiq/global_id/client_middleware'
    autoload :ServerMiddleware, 'sidekiq/global_id/server_middleware'
  end
end
