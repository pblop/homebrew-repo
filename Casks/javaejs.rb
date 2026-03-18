cask "javaejs" do
  version "6.02_BETA_210309"
  sha256 "3e79a16c68126420a360747d7a31314b2ab3491d94afe737d70b20d1c865bcd4"

  url "https://gitlab.com/ejsS/JavaScriptEditor/release/-/raw/master/JavaScript_EJS_6.02_BETA_210309.zip?inline=false"
  name "Easy Java/Javascript Simulations (EJS)"
  desc "Easy Java/Javascript Simulations"
  homepage "https://gitlab.com/ejsS/JavaScriptEditor"

  depends_on cask: "zulu@8"

  suite "JavaScript_EJS_6.02_BETA", target: "JavaEJS"

  preflight do
    File.write "#{staged_path}/javaejs", <<~EOS
      #!/bin/sh
      export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
      exec "${JAVA_HOME}/bin/java" -jar "#{appdir}/JavaEJS/EjsConsole.jar" "$@"
    EOS
  end

  binary "javaejs"
end
