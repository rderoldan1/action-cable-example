class SellsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    100.times do
      sleep(0.3)
      series = %w(serie-1 serie-2 serie-3)
      ActionCable.server.broadcast('sells', point: rand(20), serie: series.sample, name: 'test')
    end
  end
end
