class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1/cloak-1.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "af8841d83ed8f556e115e3c2eb3511124f7fbe5228a6d4b40ee521bdc46b7a6c"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1/cloak-1.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "6511dbd532111bd589a2b3123667b86a97bf764a01e6cb6868cef0885b65c224"
    end
  end

  on_linux do
    # on_arm do
    #   url "<linux-arm64-tarball-url>"
    #   sha256 "<sha>"
    # end
    # ^ uncomment when the release workflow produces a linux/arm64 tarball.
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.1/cloak-1.0.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "851279951759067b2ea39b18b118bd1c077053f59b8062e4835c8a7f52562cdd"
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
