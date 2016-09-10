module Event
  class InfluxCollection < Hashie::Trash
    include Hashie::Extensions::Coercion
    property "name"
    property "tags"
    property "values"
    coerce_key :values, Array[OpenStruct]

    def self.influx_table
      name.tableize.gsub("/","_")
    end
  end
end
