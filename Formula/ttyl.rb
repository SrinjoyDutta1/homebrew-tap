class Ttyl < Formula
  include Language::Python::Virtualenv

  desc "Your coding agents on one screen, and they call you when they need you"
  homepage "https://github.com/SrinjoyDutta1/ttyl"
  url "https://github.com/SrinjoyDutta1/ttyl/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "57bf617247daa5bf1b1461b14ba1956f70b0659ff4bb2d4e0f4e7a1fbc2143f6"
  license "MIT"

  bottle do
    root_url "https://github.com/SrinjoyDutta1/homebrew-tap/releases/download/ttyl-0.4.0"
    sha256 cellar: :any, arm64_tahoe: "71dd9620e525e1b064984dd2ee79205cdbadca29cc17efc420340bc0f4f598b5"
  end

  depends_on "rust" => :build
  depends_on "python@3.14"

  def install
    python = formula_opt_bin("python@3.14")/"python3.14"
    virtualenv_create(libexec, python)
    # Dependencies come from PyPI. The two compiled ones (pydantic-core and jiter, via anthropic)
    # are built here instead of taken as wheels: Homebrew rewrites the install name of every
    # library it installs, and the wheels' libraries have no room for a longer one.
    system python, "-m", "pip", "--python=#{libexec}/bin/python", "install", "--no-cache-dir",
           "--disable-pip-version-check", "--no-binary=jiter,pydantic-core", buildpath
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
