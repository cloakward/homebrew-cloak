class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.1-rc1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc1/cloak-1.0.1-rc1-aarch64-apple-darwin.tar.gz"
      sha256 "9ef94135c7b03140715e46c773c9a2f454df68ce5bbcfa4f5fd244bbc59f23ef"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc1/cloak-1.0.1-rc1-x86_64-apple-darwin.tar.gz"
      sha256 "1902c954bbdadaba1cf5f86cd2544bcdb00f86144a69ad62d4cc5d4bb21125b1"
    end
  end

  on_linux do
    # on_arm do
    #   url "<linux-arm64-tarball-url>"
    #   sha256 "<sha>"
    # end
    # ^ uncomment when the release workflow produces a linux/arm64 tarball.
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc1/cloak-1.0.1-rc1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "472f8f0d6fd66ed1abdcc3d9d5ae633ec2bd0ceb17c980cc409fa8c08092f48a"
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
