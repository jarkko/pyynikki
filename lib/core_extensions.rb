class Date
  def to_finnish
    self.strftime("%d.%m.%Y").gsub(/0(\d\.)/, '\1')
  end
end