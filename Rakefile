require 'rubygems'
require 'bundler'
require 'pathname'
require 'logger'
require 'fileutils'

Bundler.require

ROOT        = Pathname(File.dirname(__FILE__))
LOGGER      = Logger.new(STDOUT)
BUNDLES     = %w( application.css application.js )
BUILD_DIR   = ROOT.join("build")
SOURCE_DIR  = ROOT.join("lib", "assets")
ASSET_DIR   = "assets"

task :cleanup do
  FileUtils.rm_r BUILD_DIR if File.exists? BUILD_DIR
end

task :compile => :cleanup do
  sprockets = Sprockets::Environment.new(ROOT) do |env|
    env.logger = LOGGER
  end

  sprockets.append_path(SOURCE_DIR.join('javascripts').to_s)
  sprockets.append_path(SOURCE_DIR.join('stylesheets').to_s)

  BUNDLES.each do |bundle|
    assets = sprockets.find_asset(bundle)
    prefix, basename = assets.pathname.to_s.split('/')[-2..-1]
    p prefix, basename
    FileUtils.mkpath BUILD_DIR.join(ASSET_DIR, prefix)

    assets.write_to(BUILD_DIR.join(ASSET_DIR, prefix, basename))
    assets.to_a.each do |asset|
      # strip filename.css.foo.bar.css multiple extensions
      realname = asset.pathname.basename.to_s.split(".")[0..1].join(".")
      asset.write_to(BUILD_DIR.join(ASSET_DIR, prefix, realname))
    end
  end

  Dir.glob(ROOT.join('lib', 'public', '*')) do |path|
    FileUtils.cp_r(path, BUILD_DIR)
  end
end