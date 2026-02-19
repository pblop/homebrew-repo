class Mpvqt < Formula
  desc "Libmpv wrapper for QtQuick2 and QML"
  homepage "https://github.com/KDE/mpvqt"
  url "https://github.com/KDE/mpvqt/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "7d509600de97fa1c4d8f40e23f28a814f529b25d312de9b6be5a8dd854b335e5"
  license "LGPL-2.1-or-later"
  head "https://github.com/KDE/mpvqt.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "mpv"
  depends_on "qt@6"

  def install
    args = %W[
      -DCMAKE_BUILD_TYPE=Release
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DCMAKE_PREFIX_PATH=#{Formula["qt@6"].opt_prefix}
      -DBUILD_SHARED_LIBS=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.16)
      project(test)
      find_package(MpvQt REQUIRED)
      message(STATUS "MpvQt found: ${MpvQt_VERSION}")
    EOS

    system "cmake", ".", "-DCMAKE_PREFIX_PATH=#{prefix};#{Formula["qt@6"].opt_prefix}"
    assert_match "MpvQt found:", shell_output("cmake . 2>&1")
  end
end
