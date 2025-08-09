class MaschineDriver < Formula
  desc "User-space driver and tools for Native Instruments Maschine Mikro"
  homepage "https://github.com/jagoff/maschine-driver"
  url "https://github.com/jagoff/maschine-driver/releases/download/v0.1.0/maschine-driver-macos-arm64-v0.1.0.tar.gz"
  sha256 "9c3579191779e1ba00477760fc1a011382f7bdba28e75da8a3f592f402559a45"
  license :cannot_represent

  def install
    bin.install "maschine_native_driver"

    (bin/"maschine_driver").write <<~EOS
      #!/bin/bash
      exec "#{bin}/maschine_native_driver" "$@"
    EOS
    chmod 0555, bin/"maschine_driver"
  end

  test do
    assert_match "Maschine", shell_output("#{bin}/maschine_driver --help 2>&1", 0)
  end
end
