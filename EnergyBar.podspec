Pod::Spec.new do |spec|
  spec.name         = "EnergyBar"
  spec.version      = "0.1.2"
  spec.summary      = "Simeple Message bar like Android's SnackBar"
  spec.description  = <<-DESC
Energy Bar is very simple message bar that get to user's response.
                   DESC
  spec.homepage     = "https://github.com/Koosj/EnergyBar"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Bonsung Koo" => "developer@koosj.io" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/Koosj/EnergyBar.git", :tag => "#{spec.version}" }
  spec.source_files  = "energybar/*.swift"
