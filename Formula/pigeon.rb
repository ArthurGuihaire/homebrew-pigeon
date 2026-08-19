class Pigeon < Formula
  desc "The pigeon application"
  homepage "https://github.com/ArthurGuihaire/pigeon"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.0/pigeon-aarch64-apple-darwin.tar.xz"
      sha256 "959ca29420a9dc11f1097af567c7fdb69fa72ddccb880fb04267a76477f30528"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.0/pigeon-x86_64-apple-darwin.tar.xz"
      sha256 "3587711b59f6f7936ba17d03fb0a09b7ba4a5c945765ef2441d37ea1a42c85e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.0/pigeon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4797ccda5bba60ed1e5f894f59c6abdc34fad797ce317ae6c6eef8b38a242c9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.0/pigeon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a57a358cf4f14faab826d58b41b35e8a04a5e02290c20292efff8614ca05334e"
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
