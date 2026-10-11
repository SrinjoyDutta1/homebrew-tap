# srinjoydutta1/tap

Homebrew formulae for [ttyl](https://github.com/SrinjoyDutta1/ttyl): your coding agents on one
screen, and they call you when they need you.

```sh
brew install srinjoydutta1/tap/ttyl
```

Then `ttyl` for the terminal view, `ttyl app` for the menu bar app, `ttyl --demo` to try it.

## Releasing (for maintainers)

A new ttyl tag gets picked up by the daily `brew bump` workflow, which opens a pull request.
`brew test-bot` builds bottles on it; once it's green, run the **brew pr-pull** workflow with
the pull request number to publish the bottles and merge.
