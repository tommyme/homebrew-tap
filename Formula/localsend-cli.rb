# typed: true
# frozen_string_literal: true

class LocalsendCli < Formula
  desc "Send and receive files over LAN via CLI"
  homepage "https://localsend.org"
  version "1.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tommyme/localsend/releases/download/cli-v1.0.2/localsend-macos-arm64"
      sha256 "61b5ec7801229708eb52a030e9b5950c7e9de1becba4b81eb721e0821eb67eed"
    end
    on_intel do
      url "https://github.com/tommyme/localsend/releases/download/cli-v1.0.2/localsend-macos-x64"
      sha256 "e0c1557074028db3278c5ce2d50e12dbb05285f155fc47ff9e84326dab69fc68"
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    bin.install "localsend-macos-#{arch}" => "localsend"
  end

  service do
    run [opt_bin/"localsend", "--receive", "--auto", "--output", Dir.home + "/Downloads"]
    keep_alive true
    log_path "#{var}/log/localsend.log"
    error_log_path "#{var}/log/localsend.log"
  end

  def caveats
    <<~EOS
      Usage:
        localsend list              # List devices
        localsend send "Name" file.txt  # Send file
        localsend send "Name" --text "Hello"  # Send text
        localsend send "Name" --clipboard  # Send clipboard

      Background service:
        brew services start tommyme/tap/localsend-cli
    EOS
  end
end
