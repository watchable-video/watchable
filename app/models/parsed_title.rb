class ParsedTitle

  attr_reader :original_title, :channel_title

  def initialize(original_title, channel_title)
    @original_title = original_title
    @channel_title = channel_title
  end

  def title
    remove_channel_name(title_parts.first)
  end

  def subtitle
    remove_channel_name(title_parts.drop(1))
  end

  private

    def remove_channel_name(value)
      if value.is_a?(Array)
        value = value - [channel_title]
        value.join(" ")
      else
        value.sub("#{channel_title}: ", "")
      end
    end

    def title_parts
      @original_title.split(/\s[\|-—-]\s/)
    end

end
