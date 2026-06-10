class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.0.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.7/cloak-1.0.7-aarch64-apple-darwin.tar.gz"
      sha256 "f1df10d119a90c7fd1b30d690b3672a1940908f66ee2e167d22a03ab4c07fefa"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.7/cloak-1.0.7-x86_64-apple-darwin.tar.gz"
      sha256 "d91fc76c42aa62870e05909fd8f3964c46c796643b952d45525a9ce22be18353"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.0.7/cloak-1.0.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b3a0351ba6c3e4ee13a973a028f15f9922b69b808ec03c40e63fe134bb452e1"
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
