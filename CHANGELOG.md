# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2019-08-14
### Changed
- Don't pin Chromedriver version
- Dynamically set Chrome path to improve Heroku compatibility
- Update Selenium driver options

## [0.2.1] - 2019-07-14
### Changed
- Remove custom #inspect output as this interferes with lazy data loading

## [0.2.0] - 2019-07-14
### Changed
- Refactor page status internals
- Lazy load post attributes

### Fixed
- Check page status before accessing data (closes [#2](https://github.com/richardvenneman/instagrammer/issues/2))

## [0.1.3] - 2019-06-20
### Changed
- Setup test coverage
- Order load order to setup namespace early on (should fix Bootsnap issues)

## [0.1.2] - 2019-06-20
### Added
- Configure Travis to run daily

### Removed
- Remove Gemfile.lock from repo

## [0.1.1] - 2019-06-20
### Changed
- Pin chromedriver version for CI compatibility

## [0.1.0] - 2019-06-19
### Added
- Initial release
