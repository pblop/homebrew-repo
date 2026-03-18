class Javaejs < Formula
  desc "Easy Java/Javascript Simulations (EJS)"
  homepage "https://gitlab.com/ejsS/JavaScriptEditor"
  url "https://gitlab.com/ejsS/JavaScriptEditor/release/-/raw/master/JavaScript_EJS_6.02_BETA_210309.zip?inline=false"
  version "6.02_BETA_210309"
  sha256 "3e79a16c68126420a360747d7a31314b2ab3491d94afe737d70b20d1c865bcd4"
  license "GPL-3.0-or-later"

  # openjdk@8 requires x86_64, so zulu it is.
  depends_on "zulu@8"

  def install
    libexec.install Dir["*"]
    bin.write_jar_script libexec/"EjsConsole.jar", "javaejs", java_version: "1.8"
  end

  test do
    assert_predicate bin/"javaejs", :exist?
    assert_predicate libexec/"EjsConsole.jar", :exist?
  end
end
