RSpec.describe RSpec::Sidekiq::Matchers::HaveEnqueuedJob do
  let(:book) { Book.create! }
  class MatcherWorker
    include Sidekiq::Worker

    def perform(*)
    end
  end

  describe 'Hash' do
    specify 'string keys' do
      MatcherWorker.perform_async([{ 'foo' => 'bar' }])
      expect(MatcherWorker).to have_enqueued_job([{ 'foo' => 'bar' }])
    end

    specify 'symbol keys' do
      MatcherWorker.perform_async([{ foo: 'bar' }])
      expect(MatcherWorker).to have_enqueued_job([{ foo: 'bar' }])
    end

    specify 'with indifferent access' do
      MatcherWorker.perform_async([{ foo: 'bar' }.with_indifferent_access])
      expect(MatcherWorker).to have_enqueued_job([{ foo: 'bar' }])
      expect(MatcherWorker).to have_enqueued_job([{ 'foo' => 'bar' }])
    end
  end
end
