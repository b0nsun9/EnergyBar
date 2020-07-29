Pod::Spec.new do |spec|
  spec.name         = "EnergyBar"
  spec.version      = "0.1.3"
  spec.summary      = "Simeple Message bar like Android's SnackBar"
  spec.description  = "Energy Bar is very simple message bar that get to user's response."
  spec.homepage     = "https://github.com/Koosj/EnergyBar"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Bonsung Koo" => "developer@koosj.io" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/Koosj/EnergyBar.git", :tag => "#{spec.version}" }
  spec.source_files = "energybar/*.swift"
end
