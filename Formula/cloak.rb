class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.4/cloak-1.0.4-aarch64-apple-darwin.tar.gz"
      sha256 "0d5490d59c092c78270562c1f7bec8208b49bf8544d551cb7b515edaf287ebee"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.4/cloak-1.0.4-x86_64-apple-darwin.tar.gz"
      sha256 "25c64e3d73edbc629efd2255cfa9c424507b9066bbcfbe007c086fbdb12d6617"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.4/cloak-1.0.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d5c29eedd4914c5e379abb71405aa3d11ce149aeda17860c375ffdd5d4e79e34"
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
