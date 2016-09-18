require 'influxdb'

class AddUniqueVisitsCq < ActiveRecord::Migration
  def self.up
    influxdb = InfluxDB::Client.new host: "localhost"
    database = "engagement_#{Rails.env}"
    name = "unique_visits_1d"
    query = "SELECT COUNT(DISTINCT(session_id)) INTO unique_visits_1d FROM event_scores GROUP BY source_url, session_id, time(1d)"
    influxdb.create_continuous_query(name, database, query)
  end

  def self.down
    influxdb = InfluxDB::Client.new host: "localhost"
    database = "engagement_#{Rails.env}"
    name = "unique_visits_1d"
    influxdb.delete_continuous_query(name, database)
  end
end