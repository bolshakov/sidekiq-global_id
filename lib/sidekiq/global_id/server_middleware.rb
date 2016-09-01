module Sidekiq
  module GlobalId
    # Sidekiq client middleware deserializes arguments before
    # executing job.
    class ServerMiddleware
      # @param _worker [Sidekiq::Worker]
      # @param job [Hash] sidekiq job
      # @param _queue [String]
      # @return [<any>] job args
      def call(_worker, job, _queue)
        job['args'] = ActiveJob::Arguments.deserialize(job['args'])
        yield
      end
    end
  end
end
