class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "0.9.0-rc3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v0.9.0-rc3/cloak-0.9.0-rc3-aarch64-apple-darwin.tar.gz"
      sha256 "787e364b8b2d0e631e0a64ebdc97abfd683d5bbe391638494c406ccdcdb7d44b"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v0.9.0-rc3/cloak-0.9.0-rc3-x86_64-apple-darwin.tar.gz"
      sha256 "dfe91284670a58c4cd4891d0d7f0812d875f958d7bbf55dc72af6f7c81fc7df4"
    end
  end

  on_linux do
    # on_arm do
    #   url "<linux-arm64-tarball-url>"
    #   sha256 "<sha>"
    # end
    # ^ uncomment when the release workflow produces a linux/arm64 tarball.
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v0.9.0-rc3/cloak-0.9.0-rc3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "483ba3920aaf1f1c3f0a7a5936331a447d6703f52172bd47cd715b217fc6a006"
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
