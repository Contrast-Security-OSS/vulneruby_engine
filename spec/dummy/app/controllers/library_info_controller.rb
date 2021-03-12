PATHS = '**/*.{rb,c,h,c++,cpp,java,rs}'
class LibraryInfoController < ApplicationController
  # Get a library's information--hash and files.
  def info
    # Memoize on class var.
    # Takes a couples seconds to collect all the first time.
    @@mapper ||=
      begin
        mapper = {}
        Gem.loaded_specs.each_pair do |gemname, gemspec|
          next if Pathname.new(gemspec.loaded_from).directory?

          files = gemspec.full_require_paths.flat_map { |file| Pathname(file).glob(PATHS) }
          gemfile = gemfile_for(gemspec)
          digest = gemfile.exist? ? Digest::SHA256.file(gemfile).to_s : ''
          mapper[gemname] = { hash: digest, files: files, version: gemspec.version.to_s }
        end
        mapper
      end
    render(json: @@mapper.fetch(params.fetch('lib', nil), @@mapper))
  end

  # Given gemspec return gemfile.
  # Does not check for path existence.
  #
  # @param gemspec [Gem::Gemspec]
  # @return [pathname] the gemfile path.
  def gemfile_for gemspec
    Pathname(gemspec.gems_dir).parent / 'cache' / gemspec.file_name
  end
end
