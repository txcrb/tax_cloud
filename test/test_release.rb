# frozen_string_literal: true

require 'minitest/autorun'

if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3') &&
   Gem.loaded_specs.key?('ruby-gem-release')
  require_relative '../script/release'
  require 'ruby-gem-release/rspec'

  # Runs the real release tasks against a local fixture, without contacting RubyGems or GitHub.
  class TestRelease < Minitest::Test
    include RubyGemRelease::RSpec

    ROOT = File.expand_path('..', __dir__)
    VERSION_PATH = 'lib/tax_cloud/version.rb'
    FIXTURE_FILES = %w[
      tax_cloud.gemspec script/release.rb lib/**/*.rb CHANGELOG.md LICENSE.md README.md RELEASING.md
    ].freeze
    PLACEHOLDER = '* Your contribution here.'
    NOTE = '* [#1](https://github.com/txcrb/tax_cloud/pull/1): Added a feature - [@dblock](https://github.com/dblock).'

    def test_builds_the_standard_ruby_gem_release_workflow
      assert_kind_of RubyGemRelease::Workflow::RubyGem, TaxCloudRelease.workflow
    end

    def test_dates_the_release_and_prepares_the_next_patch_version
      with_project(NOTE) do |project|
        project.release!

        released = project.remote_file('v1.2.0', 'CHANGELOG.md')
        assert_match(%r{\A# Changelog\n\n## 1\.2\.0 \(\d{4}/\d{2}/\d{2}\)\n\n}, released)
        assert_includes released, NOTE
        refute_includes released, '(Next)'
        refute_includes released, PLACEHOLDER
        assert_includes project.remote_file('v1.2.0', VERSION_PATH), "VERSION = '1.2.0'"

        pending = project.remote_file('master', 'CHANGELOG.md')
        assert pending.start_with?("# Changelog\n\n## 1.2.1 (Next)\n\n#{PLACEHOLDER}\n\n## 1.2.0 ("), pending
        assert_includes project.remote_file('master', VERSION_PATH), "VERSION = '1.2.1'"
        assert_empty project.git('status', '--porcelain')
      end
    end

    def test_rejects_placeholder_only_notes_without_changing_files_or_remote_refs
      with_project(nil) do |project|
        original = project.git('rev-parse', 'origin/master')
        project.run_task('release:workflow:capture')

        error = assert_raises(RuntimeError) { project.run_task('release:validate') }
        assert_match(/no pending changelog notes/, error.message)
        assert_empty project.git('status', '--porcelain')
        assert_equal original, project.git('rev-parse', 'origin/master')
      end
    end

    private

    def changelog(notes)
      [
        '# Changelog', '',
        '## 1.2.0 (Next)', '', notes, PLACEHOLDER, '',
        '## 1.1.0 (2026/01/01)', '', '* Previous release.', ''
      ].compact.join("\n")
    end

    def write_version(project, version)
      source = File.read(File.join(ROOT, VERSION_PATH))
      project.write(VERSION_PATH, source.sub(/VERSION = (['"])[^'"]+\1/, "VERSION = '#{version}'"))
    end

    def with_project(notes)
      with_release_project do |project|
        project.copy_files(path: ROOT, files: FIXTURE_FILES)
        project.configure_workflow(require: 'script/release', builder: 'TaxCloudRelease.workflow')
        project.write('CHANGELOG.md', changelog(notes))
        write_version(project, '1.2.0')
        project.commit!
        yield project
      end
    end
  end
end
