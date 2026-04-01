class CornerScroll < Formula
  desc "macOS corner scroll daemon: bottom-left=brightness, bottom-right=volume"
  homepage "https://github.com/tommyme/corner-scroll"
  url "https://github.com/tommyme/corner-scroll/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "756c5315245e972c7d86aa8eba8976810e77d2a3bf5bc340efae3e8a42dba9cc"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "corner-scroll.swift",
           "-o", "corner-scroll",
           "-framework", "AppKit",
           "-framework", "CoreGraphics"
    bin.install "corner-scroll"
  end

  service do
    run opt_bin/"corner-scroll"
    keep_alive true
    log_path var/"log/corner-scroll.log"
    error_log_path var/"log/corner-scroll.log"
  end

  def caveats
    <<~EOS
      corner-scroll needs Accessibility permission on first run.
      Grant it in: System Settings > Privacy & Security > Accessibility

      Start the background daemon:
        brew services start corner-scroll

      Usage:
        Scroll in bottom-left corner  → brightness
        Scroll in bottom-right corner → volume
        Hold Option while scrolling   → fine-grained (1/4 step)
    EOS
  end

  test do
    assert_predicate bin/"corner-scroll", :exist?
  end
end
