# features/config/initializers/report_builder.rb

require 'report_builder'
require 'erb'
require 'pathname'

module ReportBuilder
  # Overriding Builder::get method to avoid deprecated
  class Builder
    def get(template)
      @erb ||= {}
      gem_path = Gem::Specification.find_by_name('report_builder').gem_dir
      template_path = File.join(gem_path, 'template', "#{template}.erb")
      @erb[template] ||= ERB.new(
        File.read(template_path),
        trim_mode: nil,
        eoutvar: "_#{template}"
      )
    end
  end
end
