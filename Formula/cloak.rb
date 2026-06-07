class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.6/cloak-1.0.6-aarch64-apple-darwin.tar.gz"
      sha256 "0517a214feed1eb5e7704f30db76970f6743fae3a4204a333be660c6f23cfe3e"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.6/cloak-1.0.6-x86_64-apple-darwin.tar.gz"
      sha256 "f4dd5f6571546d165da6717e770cc0463a3a21387a9bb5bf81f99c7cb766d032"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.6/cloak-1.0.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "88f888d6c7ffc72bc02573bf92655e0b2ec4990737e457232eae786a7ed1da93"
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
