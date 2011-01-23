require 'test_helper'

class DslTest < Test::Unit::TestCase
  def test_dsl
    spec    = File.read(File.expand_path("../../fixtures/simple.rb", __FILE__))
    cluster = Nebula::Dsl.evaluate spec
    p cluster
  end
end