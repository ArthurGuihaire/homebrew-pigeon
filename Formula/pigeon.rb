class Pigeon < Formula
  desc "The pigeon application"
  homepage "https://github.com/ArthurGuihaire/pigeon"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.3.1/pigeon-aarch64-apple-darwin.tar.xz"
      sha256 "dd5a85d37308e246c92714db25033286bdae03de7f7eaefe51753f09daa21012"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.3.1/pigeon-x86_64-apple-darwin.tar.xz"
      sha256 "8a659c34eb676a3e7f3b7f2c03b1247c41d052d45ebbabe15e3b3daf814b29ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.3.1/pigeon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e53b1c8d1ee2417f48adeead80a5c722e17fe202007edd4b768983e3681474d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.3.1/pigeon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4341bc6d3d2c6d1d81bc0fee1a06098f8df603b32d15010d77cd54aae9ec0742"
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
