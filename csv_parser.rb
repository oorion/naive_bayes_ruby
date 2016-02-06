require 'csv'

class CSVParser
  def initialize(path)
    @path = path
  end

  def parse
    CSV.parse(file, headers: true)
  end

  private

  def file
    File.open(@path, 'r')
  end
end
