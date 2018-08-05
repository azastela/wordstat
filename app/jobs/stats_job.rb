class StatsJob
  include SuckerPunch::Job
  workers 1

  def perform(input)
    StatsService.new(input).perform
  end
end