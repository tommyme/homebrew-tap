# typed: true
# frozen_string_literal: true

class LocalsendCli < Formula
  desc "Send and receive files over LAN via CLI"
  homepage "https://localsend.org"
  version "1.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tommyme/localsend/releases/download/cli-v1.0.1/localsend_macos_arm64"
      sha256 "c82a42a1c116ccdcf53d7aff34ec776fed49f4c430948c9fdc7d7a2ae953fc6f"
    end
    on_intel do
      url "https://github.com/tommyme/localsend/releases/download/cli-v1.0.1/localsend_macos_x86_64"
      sha256 "40905a62c0f2411eec051bb69090f4a67a5bbdf6c9b3b9e1f4de1f0efe326854"
    end
  end

  def install
    suffix = Hardware::CPU.arm? ? "macos_arm64" : "macos_x86_64"
    bin.install "localsend_#{suffix}" => "localsend"
  end

  service do
    run [opt_bin/"localsend", "--receive", "--auto", "--output", Dir.home + "/Downloads"]
    keep_alive true
    log_path "#{var}/log/localsend.log"
    error_log_path "#{var}/log/localsend.log"
  end

  def caveats
    "Run: brew services start tommyme/tap/localsend-cli"
  end
end
