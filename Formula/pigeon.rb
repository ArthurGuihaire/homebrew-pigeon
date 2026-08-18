class Pigeon < Formula
  desc "The pigeon application"
  homepage "https://github.com/ArthurGuihaire/pigeon"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.2.2/pigeon-aarch64-apple-darwin.tar.xz"
      sha256 "54946cb094e973c1d99db026aaa28d2df8ed4da5869d5576bd4cfbabfe0ce9b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.2.2/pigeon-x86_64-apple-darwin.tar.xz"
      sha256 "3311414f263eaaee2e2a3e9925cbcd94ddf2d088281f62a42dd0f59beb501d32"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.2.2/pigeon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5aacb94a29774376f2a251172bddf4df505e4640a0db097d41901a1a91091161"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.2.2/pigeon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9a9748348e61953d68f7a200ed6f2317cf2bf735d876491870954a8db34e1ffe"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pigeon", "server"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pigeon", "server"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pigeon", "server"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pigeon", "server"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
