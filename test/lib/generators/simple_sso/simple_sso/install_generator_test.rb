require 'test_helper'
require 'generators/simple_sso/install/install_generator'

module SimpleSso
  class SimpleSso::InstallGeneratorTest < Rails::Generators::TestCase
    tests SimpleSso::InstallGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
