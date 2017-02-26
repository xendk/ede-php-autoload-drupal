[![Build Status](https://travis-ci.org/xendk/ede-php-autoload-drupal.svg?branch=master)](https://travis-ci.org/xendk/ede-php-autoload-drupal)
[![MELPA Stable](https://stable.melpa.org/packages/ede-php-autoload-drupal-badge.svg)](https://stable.melpa.org/#/ede-php-autoload-drupal)
[![MELPA](https://melpa.org/packages/ede-php-autoload-drupal-badge.svg)](https://melpa.org/#/ede-php-autoload-drupal)

# ede-php-autoload-drupal

## Description

This project adds support for [Drupal][] 8+ to [ede-php-autoload][].

Supplies ede-php-autoload with information on the classes located
in modules in a Drupal project. All modules found in `core/modules`,
`modules`, `profiles/<profile>/modules` and `sites/<sites, including
default and all>/modules` is added.

As Drupal uses [composer/installers][],
[ede-php-autoload-composer-installers][] is required for practical use.

[Drupal]: http://drupal.org/
[ede-php-autoload]: https://github.com/stevenremot/ede-php-autoload/
[composer/installers]: https://github.com/composer/installers
[ede-php-autoload-composer-installers]: https://github.com/xendk/ede-php-autoload-composer-installers

## License

This project is released under the GPL v3 license. See `GPL` for
details.
