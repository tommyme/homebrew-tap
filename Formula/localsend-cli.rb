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
    # The downloaded binary has arch suffix, rename to 'localsend'
    arch_suffix = Hardware::CPU.arm? ? "_macos_arm64" : "_macos_x86_64"
    FileUtils.cp staged_path.join("localsend#{arch_suffix}"), bin/"localsend"
    chmod 0755, bin/"localsend"
  end

  def plist
    <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>org.localsend.localsend-cli</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/localsend</string>
          <string>--receive</string>
          <string>--auto</string>
          <string>--output</string>
          <string>#{ENV["HOME"]}/Downloads</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>StandardOutPath</key>
        <string>/var/log/localsend.log</string>
        <key>StandardErrorPath</key>
        <string>/var/log/localsend.log</string>
      </dict>
      </plist>
    PLIST
  end

  test do
    system "#{bin}/localsend", "--help"
  end
end
