class MaschineDriver < Formula
  desc "User-space driver and tools for Native Instruments Maschine Mikro"
  homepage "https://github.com/jagoff/maschine-driver"
  url "https://github.com/jagoff/maschine-driver/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "85811031c55ee41719c0bb08f2b82a120d13151d798a015d9f205c5ca73dd03e"
  license :cannot_represent

  depends_on xcode: :build

  def install
    # Build the user-space driver binary using provided Makefile.maschine
    system "make", "-f", "Makefile.maschine"
    bin.install "maschine_native_driver"

    # Convenience wrapper matching README commands
    (bin/"maschine_driver").write <<~EOS
      #!/bin/bash
      exec "#{bin}/maschine_native_driver" "$@"
    EOS
    chmod 0555, bin/"maschine_driver"
  end

  test do
    # Verify the binary is present and prints help without crashing
    assert_match "Maschine", shell_output("#{bin}/maschine_driver --help 2>&1", 0)
  end
end
