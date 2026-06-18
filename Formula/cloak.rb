class Cloak < Formula
  desc "MCP-native local secrets vault"
  homepage "https://github.com/cloakward/cloak"
  version "1.1.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cloakward/cloak/releases/download/v1.1.2/cloak-1.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "5f262e276d5083233c436875f2263f817e260988d79c5221e44ab104f8d8b43d"
    end
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.1.2/cloak-1.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "d9d59a5e96978ba5cdd83207d06d6b530cb4c0cd3441dc0fb3f6a1fc871cc58c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cloakward/cloak/releases/download/v1.1.2/cloak-1.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d3a3d76c56620d51087955736d00ce3eca9a7c707be712a75960d5d8ee8a00f"
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
