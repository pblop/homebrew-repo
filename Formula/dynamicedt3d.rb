class Dynamicedt3d < Formula
  desc "DynamicEDT3D library from OctoMap (needed for pyoctomap)"
  homepage "https://octomap.github.io/"
  url "https://github.com/OctoMap/octomap/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "8da2576ec6a0993e8900db7f91083be8682d8397a7be0752c85d1b7dd1b8e992"
  license "BSD-3-Clause"

  depends_on "octomap"
  depends_on "cmake" => :build
  depends_on "pkgconf" => :test

  def install
    system "cmake", "-S", "dynamicEDT3D", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
