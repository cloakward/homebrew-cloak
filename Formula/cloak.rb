class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.1-rc3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc3/cloak-1.0.1-rc3-aarch64-apple-darwin.tar.gz"
      sha256 "2af88dc6bb90aad2d7613ad1c7fa8041ff66ac4a05703d430ecf394712de84cc"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc3/cloak-1.0.1-rc3-x86_64-apple-darwin.tar.gz"
      sha256 "251d4fcd85d1f2c0d00948be6c50b3eaa09b76f4d50eaa54b5e42fbbe3f91234"
    end
  end

  on_linux do
    # on_arm do
    #   url "<linux-arm64-tarball-url>"
    #   sha256 "<sha>"
    # end
    # ^ uncomment when the release workflow produces a linux/arm64 tarball.
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc3/cloak-1.0.1-rc3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ab237b47d501d1367dd8237cb3c8ffd7c7ee649b881be75566443ff4a431336f"
    end
  end

  depends_on "libsodium"

  def install
    bin.install "bin/cloak"
    bin.install "bin/cloakd"
    # cloak-mcp is bundled in the macOS arm64, macOS x64, and Linux
    # gnu amd64 tarballs (the platforms `bun --compile` can target
    # from the release runners). Install if present.
    bin.install "bin/cloak-mcp" if File.exist?("bin/cloak-mcp")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloak --version")
  end
end
