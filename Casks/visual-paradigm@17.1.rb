cask "visual-paradigm@17.1" do
  arch arm: "AArch64", intel: "WithJRE"

  version "17.1"
  sha256 arm:   "0246f441c62a3c9486c96798f6e287e1a77d41ee83f471b57ae9adc5eb1bc91c",
         intel: "fcc3503007be435a5d7f1fdea8a0aa7dfba03972428ed613327b2dcb5bfb36ce"

  url "https://www.visual-paradigm.com/downloads/vp#{version}/Visual_Paradigm_OSX_#{arch}.dmg"
  name "Visual Paradigm"
  desc "UML, SysML, BPMN modelling platform"
  homepage "https://www.visual-paradigm.com/"

  app "Visual Paradigm.app"

  zap trash: [
    "~/Library/Application Support/Visual Paradigm",
    "~/Library/Application Support/VisualParadigm",
    "~/Library/Saved Application State/com.install4j.1106-5897-7327-6550.5.savedState",
  ]
end
