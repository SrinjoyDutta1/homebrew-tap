class Ttyl < Formula
  include Language::Python::Virtualenv

  desc "Your coding agents on one screen, and they call you when they need you"
  homepage "https://github.com/SrinjoyDutta1/ttyl"
  url "https://github.com/SrinjoyDutta1/ttyl/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "57bf617247daa5bf1b1461b14ba1956f70b0659ff4bb2d4e0f4e7a1fbc2143f6"
  license "MIT"

  depends_on "python@3.14"

  def install
    python = formula_opt_bin("python@3.14")/"python3.14"
    virtualenv_create(libexec, python)
    # Dependencies come from PyPI as prebuilt wheels: anthropic's pydantic-core and jiter
    # would otherwise need a Rust toolchain on every install.
    system python, "-m", "pip", "--python=#{libexec}/bin/python", "install",
           "--no-cache-dir", "--disable-pip-version-check", buildpath
    bin.install_symlink libexec/"bin/ttyl"
  end

  def caveats
    <<~EOS
      ttyl          the terminal view
      ttyl app      the menu bar app (builds itself the first time, ~20s; needs
                    Apple's Command Line Tools: xcode-select --install)
      ttyl --demo   try either on made-up sessions
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ttyl --version")
    assert_match "NEEDS YOU", shell_output("#{bin}/ttyl ls --demo")
  end
end
