if defined? Motion::Project::App
  Motion::Project::App.setup do |config|
    # Inject helpers that provide a (Mini)?Test::Unit adaptor
    __dir__ = File.dirname(File.realpath(__FILE__))
    helpers = Dir[File.join(__dir__, 'kosher_bacon', 'adaptor.rb')]
    # Place kosher_bacon helpers immediately before the app's spec files.
    # An app's spec files are immediately after RubyMotion's.
    before_app_specs = config.spec_files.index { |file| !file.start_with?(config.motiondir) }
    config.spec_files.insert(before_app_specs, *helpers)
  end
else
  raise 'This file must be required within a RubyMotion project Rakefile.'
end
