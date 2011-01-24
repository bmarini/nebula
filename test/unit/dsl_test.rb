require 'test_helper'

class DslTest < Test::Unit::TestCase
  def test_dsl
    Fog.mock!
    spec = File.read(File.expand_path("../../fixtures/simple.rb", __FILE__))

    cloud = Nebula::Dsl.evaluate spec
    Nebula::Builder.build cloud
  end
end