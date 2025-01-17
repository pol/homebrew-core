class PangommAT246 < Formula
  desc "C++ interface to Pango"
  homepage "https://www.pango.org/"
  url "https://download.gnome.org/sources/pangomm/2.46/pangomm-2.46.3.tar.xz"
  sha256 "410fe04d471a608f3f0273d3a17d840241d911ed0ff2c758a9859c66c6f24379"
  license "LGPL-2.1-only"

  livecheck do
    url :stable
    regex(/pangomm-(2\.46(?:\.\d+)*)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_sonoma:   "44eea89bd24d065a36663988e7ad5a5efba930288c885411ee814e30927ec5a1"
    sha256 cellar: :any, arm64_ventura:  "34b42ded79cde5e0e0cf3e1801436cd02ac7462a2e78597d496c634ccf5cfc83"
    sha256 cellar: :any, arm64_monterey: "70829eb5c5110ae6e8c0797080bae7d54b101d48e5b93d7858bd13b61f73d286"
    sha256 cellar: :any, arm64_big_sur:  "fa06e509cea917f2086a2b24ad367edc21470bd69f8a9a2ee1b699e23df24494"
    sha256 cellar: :any, sonoma:         "c1963ee838036a7cd11108d98f023087615504a01364a54538014dd070bafe58"
    sha256 cellar: :any, ventura:        "26891221881ab706d5e49a0ef34a2b6f785752cad5797d53ee1368bf15a016ec"
    sha256 cellar: :any, monterey:       "cfd030509949ebe467ecd80530a689599d6374363760097e3d200f0e7c2ccf9d"
    sha256 cellar: :any, big_sur:        "36ae7e79632f6040ee0b0e4ebc2f6c9ec19f297460524abe2bcfac7c92f939e3"
    sha256 cellar: :any, catalina:       "0fb962aad84cc9a9053dd1d60cf0bf46102aaf6f20bc4872b6d5a45fdbe3f5f6"
    sha256               x86_64_linux:   "cfbf4d51df7507bec4200db5635968917757ac6e2de071fc52e836fe837fc98d"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "cairomm@1.14"
  depends_on "glibmm@2.66"
  depends_on "pango"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end
  test do
    (testpath/"test.cpp").write <<~EOS
      #include <pangomm.h>
      int main(int argc, char *argv[])
      {
        Pango::FontDescription fd;
        return 0;
      }
    EOS

    pkg_config_cflags = shell_output("pkg-config --cflags --libs pangomm-1.4").chomp.split
    system ENV.cxx, "-std=c++11", "test.cpp", *pkg_config_cflags, "-o", "test"
    system "./test"
  end
end
