class PlantumlPdf < Formula
  desc "Draw UML diagrams"
  homepage "https://plantuml.com/"
  url "https://github.com/plantuml/plantuml/releases/download/v1.2025.3/plantuml-pdf-1.2025.3.jar"
  sha256 "a3c6c13bd0ab72b7f65cbb8b6da912894a7859c21a9c9253470943af8c9d2f42"
  license "GPL-3.0-or-later"
  version_scheme 1

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "graphviz"
  depends_on "openjdk"

  def install
    jar = "plantuml-pdf.jar"
    libexec.install "plantuml-pdf-#{version}.jar" => jar
    (bin/"plantuml-pdf").write <<~EOS
      #!/bin/bash
      if [[ "$*" != *"-gui"* ]]; then
        VMARGS="-Djava.awt.headless=true"
      fi
      GRAPHVIZ_DOT="#{Formula["graphviz"].opt_bin}/dot" exec "#{Formula["openjdk"].opt_bin}/java" $VMARGS -jar #{libexec}/#{jar} "$@"
    EOS
    chmod 0755, bin/"plantuml-pdf"
  end

  test do
    system bin/"plantuml-pdf", "-testdot"
  end
end
