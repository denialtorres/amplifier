class ProcessUploadedFileJob < ApplicationJob
  queue_as :semantic

  def perform(*args)
    # Simulates a long, time-consuming task
    sleep 5
    # Will display current time, milliseconds included
    puts "hello from ProcessUploadedFileJob #{Time.now().strftime('%F - %H:%M:%S.%L')}"
  end
end
