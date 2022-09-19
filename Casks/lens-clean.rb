cask "lens-clean" do
    arch = Hardware::CPU.intel? ? "" : "-arm64"
  
    version "6.0.2,20220908.1"
  
    if Hardware::CPU.intel?
      sha256 "15f51ef1f9b99abec8e0ee79075edb5d49ab23602096dcbbf8699c0f22c896bb"
    else
      sha256 "b71e07a2f94d723bae0fc8dc9854f661db8f755838d51ca075eafb43adc2c49e"
    end
  
    url "https://api.k8slens.dev/binaries/Lens-#{version.csv.first}-latest.#{version.csv.second}#{arch}.dmg"
    name "LensClean"
    desc "Kubernetes IDE without junk"
    homepage "https://k8slens.dev/"
  
    livecheck do
      url "https://lens-binaries.s3.amazonaws.com/ide/latest-mac.yml"
      strategy :electron_builder do |data|
        data["version"].sub("-latest.", ",")
      end
    end
  
    auto_updates false

    app "Lens.app", target: "LensClean.app"
    
    postflight do
        system "echo", "removing crap postflight..."
        system "rm", "-rfv", "/Applications/LensClean.app/Contents/Resources/extensions/lenscloud-lens-extension"
        system "rm", "-rfv", "/Applications/LensClean.app/Contents/Resources/extensions/telemetry"
        system "rm", "-rfv", "/Applications/LensClean.app/Contents/Resources/extensions/lens-license-extension"
        system "rm", "-rfv", "/Applications/LensClean.app/Contents/Resources/extensions/support-lens-extension"
        system "rm", "-rfv", "/Applications/LensClean.app/Contents/Resources/extensions/survey"
        system "xattr", "-crv", "/Applications/LensClean.app"
    end
  
    zap trash: [
      "~/Library/Application Support/Lens",
      "~/Library/Caches/Lens",
      "~/Library/Preferences/com.electron.kontena-lens.plist",
      "~/Library/Saved Application State/com.electron.kontena-lens.savedState",
    ]
  end
