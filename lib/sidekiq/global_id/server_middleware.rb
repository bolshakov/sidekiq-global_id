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
        _args = job['args']
        unless _worker.class.name.start_with? 'ActiveJob::'
          job['args'] = ActiveJob::Arguments.deserialize(_args)
        end
        yield
      ensure
        job['args'] = _args
      end
    end
  end
end
