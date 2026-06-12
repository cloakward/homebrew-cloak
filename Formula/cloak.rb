class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.1.0/cloak-1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "3e81041416a5a7b74a25cc4db6295ef0e13f7f5b7e53fbc923c1695c369e72c7"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.1.0/cloak-1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "c551107c1d32654d8c8c14b30c101393ecec419de3da859ec072ffbaac2a7f9b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.1.0/cloak-1.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c0c4aac191c694ea6888578d76f62a1d2996502fb19695940aa60c49c532fb3"
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
