class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.5/cloak-1.0.5-aarch64-apple-darwin.tar.gz"
      sha256 "a7c24393248ec8945e792a9d3f543da1c9d323896e2a819d96dc7060fbdaee99"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.5/cloak-1.0.5-x86_64-apple-darwin.tar.gz"
      sha256 "c4813f9e9abb617c21a0c8149d163d534e2f8bbd3b59b46635821b2d62f9b27b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.5/cloak-1.0.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6432a8b279e616dfcb3936dcd5e3a5957a413d54ea459014c0fda8d895a92761"
    end
  end

  depends_on "libsodium"

  def install
    bin.install "bin/cloak"
    bin.install "bin/cloakd"
    bin.install "bin/cloak-mcp"
    pkgshare.install "share/polkit-1/actions/dev.cloak.policy" if File.exist?("share/polkit-1/actions/dev.cloak.policy")
  end

  def caveats
    if OS.linux?
      <<~EOS
        Install Cloak's polkit action before using biometric/user-presence gated reveal:
          sudo install -Dm644 "#{pkgshare}/dev.cloak.policy" /usr/share/polkit-1/actions/dev.cloak.policy
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloak --version")
  end
end
