# rubocop:disable Style/GlobalVars
RSpec.describe Sidekiq::GlobalId::ServerMiddleware do
  let(:book) { Book.create! }
  class CustomWorker
    $args = []
    include Sidekiq::Worker

    def perform(book)
      $args = [book]
    end
  end

  around do |example|
    Sidekiq::Testing.inline! do
      example.run
    end
  end

  it 'serializes and deserializes attributes' do
    expect($args).to eq([])

    CustomWorker.perform_async(book)

    expect($args).to eq([book])
  end
end
# rubocop:enable Style/GlobalVars
