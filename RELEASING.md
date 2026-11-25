# Releasing TaxCloud

There are no hard rules about when to release tax_cloud. Release bug fixes frequently, features not so frequently, and breaking API changes rarely.

Releases use [ruby-gem-release](https://github.com/dblock/ruby-gem-release) 0.9.0 through a manually dispatched [Release workflow](.github/workflows/release.yml). Keep the `ruby-gem-release` gem in [Gemfile](Gemfile) and the reusable workflow in `release.yml` pinned to the same version. The workflow publishes through RubyGems Trusted Publishing, so no RubyGems API key or one-time password is needed. It only runs from `master` in `txcrb/tax_cloud`. The local Bundler `rake release`, `release:rubygem_push`, and `release:source_control_push` tasks are disabled.

## One-Time Setup

Before the first automated release, a maintainer must:

1. Create the GitHub environment `release` in `txcrb/tax_cloud`, for example with `gh api --method PUT repos/txcrb/tax_cloud/environments/release`, and restrict its deployment branches to `master`. Add required reviewers to require maintainer approval before publication.
2. At the [trusted publishers for tax_cloud](https://rubygems.org/gems/tax_cloud/trusted_publishers), add a GitHub Actions publisher with repository owner `txcrb`, repository `tax_cloud`, workflow filename `release.yml`, environment `release`, and the separate workflow repository owner `dblock` and repository `ruby-gem-release`.
3. Allow GitHub Actions to push release commits and `v*` tags to `master`. See the upstream [setup and permissions guidance](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/RELEASING.md#one-time-setup).

Verify the setup without publishing with a [dry run](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/docs/actions/release.md#dry-run), which never edits files, builds, pushes, or publishes:

```sh
gh workflow run release.yml --repo txcrb/tax_cloud --ref master -f dry-run=true
```

## Prepare

Start with a clean, up-to-date `master` and verify that the latest [CI checks](https://github.com/txcrb/tax_cloud/actions) pass for all supported Ruby versions. Follow semantic versioning: patch for fixes, minor for backward-compatible features, major for breaking changes. Check `VERSION` in [lib/tax_cloud/version.rb](lib/tax_cloud/version.rb) and the matching `(Next)` heading in [CHANGELOG.md](CHANGELOG.md), and change both in a pull request if needed, or pass a `version` override when dispatching.

The workflow dates the `(Next)` heading using `YYYY/MM/DD` and removes the `* Your contribution here.` placeholder; a section without notes cannot be released.

Release automation requires MRI Ruby 3.3 or newer; the release dependency and tasks are skipped on older Ruby versions and JRuby. The release test in [test/test_release.rb](test/test_release.rb) runs the actual release tasks against a local fixture with the [ruby-gem-release test helpers](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/docs/testing.md), without contacting RubyGems or GitHub.

## Publish

```sh
gh workflow run release.yml --repo txcrb/tax_cloud --ref master
```

Pass `-f version=x.y.z` to release a different version. Dispatching starts a real release; do not merge into `master` while it runs. The workflow prepares the release commit, runs lint and tests on Ruby 3.3, builds the gem, preserves recovery artifacts, publishes to RubyGems, pushes the release commit and `v` tag, and creates a GitHub Release with the changelog notes and the gem attached. It then increments the patch version, adds a new `(Next)` section, and pushes the next development commit. Verify the published version on [RubyGems](https://rubygems.org/gems/tax_cloud), the tag, the [GitHub Release](https://github.com/txcrb/tax_cloud/releases), and the next development commit.

## Recover a Partial Release

Inspect the failed run, RubyGems, remote commits and tags, and the GitHub Release before retrying. Publication may have succeeded even if a later step failed. Never move a published tag or republish a version with different contents. Use the run's retained recovery artifacts and the upstream [recovery instructions](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/docs/actions/release.md#recovery-artifacts).
