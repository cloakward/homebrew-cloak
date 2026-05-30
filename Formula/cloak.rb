class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.2/cloak-1.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "529e138363ff6c78a975478cd8a4b8bfdcccd6a5fe1933162394173ef5d70c37"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.2/cloak-1.0.2-x86_64-apple-darwin.tar.gz"
      sha256 "7c8051665e53dc7ac93a1be90c2b178519dd1bca8362263c46ace3b51febe97f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.2/cloak-1.0.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "320c8871e00399241b563196ea0126a4e1f62c9e66a8819104b1902d54ab0ba1"
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
