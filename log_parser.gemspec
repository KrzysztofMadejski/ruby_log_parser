lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "LogParser"
  spec.version       = '1.0'
  spec.authors       = ["Krzysztof Madejski"]
  spec.email         = ["krzysztof@madejscy.pl"]
  spec.summary       = %q{Parsing log file to count unique visits}
  spec.license       = "MIT"

  spec.files         = ['lib/parser.rb']
  spec.executables   = ['parser.rb']
  spec.require_paths = ["lib"]
end