class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.0/cloak-1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "753d4c812dc9e7089ffbaa17981cda220fb0639200bc2ce02df5cbd0d9ebf8c8"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.0/cloak-1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "34037255b57f126c471bf3f9cdc255c162aeb262c5d27988ebaa1bb3409d04e3"
    end
  end

  on_linux do
    # on_arm do
    #   url "<linux-arm64-tarball-url>"
    #   sha256 "<sha>"
    # end
    # ^ uncomment when the release workflow produces a linux/arm64 tarball.
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.0/cloak-1.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b085c7af809a0243b48b49b9e3cfc2ff0c9eef9f5011b742f5dbdfe2207a9095"
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
