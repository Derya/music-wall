
class String
  def fix_url
    unless self.empty? || self.starts_with?('http')
      "http://" + self
    else
      self
    end
  end
end
