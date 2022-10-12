cask "lens-clean" do
    arch = Hardware::CPU.intel? ? "" : "-arm64"
  
    version "2022.10.111653"
  
    sha256 "313367bea196021faea768d69b508f0d5d50c5d592d419cd8716eb0ffbd35e42"
  
    url "https://api.k8slens.dev/binaries/Lens-#{version}-latest#{arch}.dmg"
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
