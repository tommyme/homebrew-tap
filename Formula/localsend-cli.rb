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
      sha256 "TODO"
    end
    on_intel do
      url "https://github.com/tommyme/localsend/releases/download/cli-v1.0.2/localsend-macos-x64"
      sha256 "TODO"
    end
  end

  def install
    bin.install "localsend-macos-#{Hardware::CPU.arch}" => "localsend"
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
