require 'test_helper'

class ParsedTitleTest < ActiveSupport::TestCase

  setup do
    @title = "Title"
    @subtitle = "Subtitle"
    @channel = "Channel"
  end

  test "should get title and subtitle pipe" do
    parsed_title = ParsedTitle.new("#{@title} | #{@subtitle}", @channel)
    assert_equal(@title, parsed_title.title)
    assert_equal(@subtitle, parsed_title.subtitle)
  end

  test "should get title and subtitle dash 1" do
    parsed_title = ParsedTitle.new("#{@title} - #{@subtitle}", @channel)
    assert_equal(@title, parsed_title.title)
    assert_equal(@subtitle, parsed_title.subtitle)
  end

  test "should get title and subtitle dash 2" do
    parsed_title = ParsedTitle.new("#{@title} — #{@subtitle}", @channel)
    assert_equal(@title, parsed_title.title)
    assert_equal(@subtitle, parsed_title.subtitle)
  end

  test "should get title and subtitle dash 3" do
    parsed_title = ParsedTitle.new("#{@title} - #{@subtitle}", @channel)
    assert_equal(@title, parsed_title.title)
    assert_equal(@subtitle, parsed_title.subtitle)
  end

  test "should remove channel name from title" do
    parsed_title = ParsedTitle.new("#{@channel}: #{@title} - #{@subtitle}", @channel)
    assert_equal(@title, parsed_title.title)
    assert_equal(@subtitle, parsed_title.subtitle)
  end

  test "should remove channel name from subtitle" do
    parsed_title = ParsedTitle.new("#{@channel}: #{@title} - #{@subtitle} - #{@channel}", @channel)
    assert_equal(@title, parsed_title.title)
    assert_equal(@subtitle, parsed_title.subtitle)
  end

end
