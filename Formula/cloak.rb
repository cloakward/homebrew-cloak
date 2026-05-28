class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.1-rc2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc2/cloak-1.0.1-rc2-aarch64-apple-darwin.tar.gz"
      sha256 "64e03357ccf4b05c737de84ed0d3c7ed6297ae2cf8b408b780b1775e0f6cb8e3"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc2/cloak-1.0.1-rc2-x86_64-apple-darwin.tar.gz"
      sha256 "268f3648b3f28c267439b27d279cc9936335c385ab576bc7681b60e839aefc0c"
    end
  end

  on_linux do
    # on_arm do
    #   url "<linux-arm64-tarball-url>"
    #   sha256 "<sha>"
    # end
    # ^ uncomment when the release workflow produces a linux/arm64 tarball.
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1-rc2/cloak-1.0.1-rc2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2eab577f631ea0f6b369e7d785c4368c850ed9c2b2473383d25b30263fd14d8"
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
