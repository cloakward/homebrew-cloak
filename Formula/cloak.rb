class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.3/cloak-1.0.3-aarch64-apple-darwin.tar.gz"
      sha256 "71ed67e7ec649182d2c9561f43e098aceaddd99c1cb0bd66980f929936a36d95"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.3/cloak-1.0.3-x86_64-apple-darwin.tar.gz"
      sha256 "1cc3d83f61ab260a3f8e68e0bc6c202ec02d69b9f66ae7428d0ec943787c12db"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.3/cloak-1.0.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ba7ea71a441eccdd9d385a56d4cadaa907369039e0add37583b02d122a9ca1f9"
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
