class Array

  def to_sentence
    if self.size < 2
      self.to_s
    elsif self.size == 2
      self.join(' and ')
    else
      self[0..-2].join(', ') + ", and " + self[-1]
    end
  end

end
