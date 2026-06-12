class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.8/cloak-1.0.8-aarch64-apple-darwin.tar.gz"
      sha256 "b0174ec8740e48d092d4a272d513dad0906a6a0514ab5352a02dc12bed174cc5"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.8/cloak-1.0.8-x86_64-apple-darwin.tar.gz"
      sha256 "f785aed0e0d901d23dd102f28d4e5591639eae1d0f0133fb02c19ce4c20ed924"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.8/cloak-1.0.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "549a6595de23db41185a785bddb30d7bd281f7444fac1e9570703ba9403c8367"
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
