class Symbenforcer < Formula
  desc "Keyboard hacking tool, make it geeker to use your keys"
  homepage "https://github.com/tommyme/symbEnforcer"
  url "https://github.com/tommyme/symbEnforcer/releases/download/v1.0.0/symbEnforcer"
  sha256 "d389faa1de0eb840c5a28379bf8330889fb3eeeaaa5f99e92c65957e5856e5fd"
  license "GPL-3.0-only"

  def install
    bin.install "symbEnforcer"
  end

  test do
    system "true"
  end
end
