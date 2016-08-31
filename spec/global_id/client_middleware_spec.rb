RSpec.describe Sidekiq::GlobalId::ClientMiddleware do
  let(:book) { Book.create! }
  class CustomWorker
    include Sidekiq::Worker

    def perform(_book, _number)
    end
  end

  it 'serializes attributes' do
    CustomWorker.perform_async(book, 2)
    expect(CustomWorker).to have_enqueued_job(book, 2)
  end
end
