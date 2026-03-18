cask "javaejs" do
  version "6.02_BETA_210309"
  sha256 "3e79a16c68126420a360747d7a31314b2ab3491d94afe737d70b20d1c865bcd4"

  url "https://gitlab.com/ejsS/JavaScriptEditor/release/-/raw/master/JavaScript_EJS_6.02_BETA_210309.zip?inline=false"
  name "Easy Java/Javascript Simulations (EJS)"
  desc "Easy Java/Javascript Simulations"
  homepage "https://gitlab.com/ejsS/JavaScriptEditor"

  depends_on cask: "zulu@8"

  app "JavaEJS.app"
  binary "javaejs"

  preflight do
    File.write "#{staged_path}/javaejs", <<~EOS
      #!/bin/sh
      export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
      cd "#{staged_path}/JavaScript_EJS_6.02_BETA" | exit 1
      exec "${JAVA_HOME}/bin/java" -jar "EjsConsole.jar" "$@"
    EOS

    # Create app to launch from Finder/Launchpad.
    system_command "osacompile", args: [
      "-o", "#{staged_path}/JavaEJS.app",
      "-e", "do shell script \"#{staged_path}/javaejs > /dev/null 2>&1\""
    ]
    system_command "curl", args: [
      "-sLo", "#{staged_path}/icon.png",
      "https://gitlab.com/ejsS/JavaScriptEditor/release/-/raw/master/EJS%20JS%20Logo.png?inline=false"
    ]
    # sips requires the image to be 256x256, 512x512, or 1024x1024 to convert to
    # icns. 
    system_command "sips", args: [
      "-z", "256", "256",
      "#{staged_path}/icon.png",
      "--out", "#{staged_path}/icon.png"
    ]
    system_command "sips", args: [
      "-s", "format", "icns",
      "#{staged_path}/icon.png",
      "--out", "#{staged_path}/JavaEJS.app/Contents/Resources/applet.icns"
    ]
    system_command "rm", args: ["#{staged_path}/icon.png"]
  end
end
