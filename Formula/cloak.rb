class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "0.9.0-rc2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v0.9.0-rc2/cloak-0.9.0-rc2-aarch64-apple-darwin.tar.gz"
      sha256 "b31fbdc7b9cf605727dc63d5f14102a7bb3c3b20e83656e7d8d7a6722863f0aa"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v0.9.0-rc2/cloak-0.9.0-rc2-x86_64-apple-darwin.tar.gz"
      sha256 "e2651398d238aa107ceb7cb35a973046277df39cdf4b088f53e5a96f19a133dc"
    end
  end

  on_linux do
    # on_arm do
    #   url "<linux-arm64-tarball-url>"
    #   sha256 "<sha>"
    # end
    # ^ uncomment when the release workflow produces a linux/arm64 tarball.
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v0.9.0-rc2/cloak-0.9.0-rc2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c43756505c7bd0721740e992a0812e2265d364a4e0410a329707591fbb00155d"
    end
  end

  depends_on "libsodium"

  def install
    bin.install "bin/cloak"
    bin.install "bin/cloakd"
    # cloak-mcp is bundled in the macOS arm64, macOS x64, and Linux
    # gnu amd64 tarballs (the platforms  can target
    # from the release runners). Install if present.
    bin.install "bin/cloak-mcp" if File.exist?("bin/cloak-mcp")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloak --version")
  end
end
