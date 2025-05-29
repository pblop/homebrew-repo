class PlantumlPdf < Formula
  desc "Draw UML diagrams"
  homepage "https://plantuml.com/"
  url "https://github.com/plantuml/plantuml/releases/download/v1.2025.2/plantuml-pdf-1.2025.2.jar"
  sha256 "9833fbd812deefe5aa8c2b3122b845fff8d5415a665348f0805787dac5b5987d"
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
