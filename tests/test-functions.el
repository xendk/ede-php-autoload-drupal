;;; test-functions.el --- Tests of internal functions.  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Thomas Fini Hansen

;; Author: Thomas Fini Hansen <xen@xen.dk>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Unit tests of functions.

;;; Code:

(require 'buttercup)

(require 'f)
(defvar ede-php-autoload-drupal-fixtures)
(let ((root (f-parent (f-parent (f-this-file)))))
  (add-to-list 'load-path root)
  (setq ede-php-autoload-drupal-fixtures (f-join root "fixtures")))

(describe "ede-php-autoload-drupal--core-path"
  (it "should detect core"
    (expect
     (ede-php-autoload-drupal--core-path
      '(:psr-0 (("Test" . "test/"))
               :psr-4 (("Test3" . "test3/")
                       ("Drupal\\Core" . "/some/where/lib/Drupal/Core"))))
    :to-equal
    "/some/where")
    )

  (it "should return nil, if no core found"
    (expect
     (ede-php-autoload-drupal--core-path
      '(:psr-0 (("Test" . "test/"))
               :psr-4 (("Test3" . "test3/"))))
     :to-equal
     nil)
    )

  (it "should take the first one if there's multiple"
    (expect
     (ede-php-autoload-drupal--core-path
      '(:psr-0 (("Test" . "test/"))
               :psr-4 (("Test3" . "test3/")
                       ("Drupal\\Core" . ("/some/where/lib/Drupal/Core"
                                          "/some/where/else/lib/Drupal/Core")))))
     :to-equal
     "/some/where")))

(describe "ede-php-autoload-drupal--find-modules"
  (it "should find all modules in fixture"
    (let ((sorter (lambda (a b) (string< (car a) (car b)) )))
      (expect
       (sort (ede-php-autoload-drupal--find-modules
              (f-join ede-php-autoload-drupal-fixtures "drupal-project/vendor/drupal"))
             sorter)
       :to-equal
       (sort '(("system" . "core/modules/system")
               ("simple_module" . "modules/simple_module")
               ("main_module" . "modules/main_module")
               ("sub_module" . "modules/main_module/sub_module")
               ("profile_module" . "profiles/test_profile/modules/profile_module")
               ("default_module" . "sites/default/modules/default_module"))
             sorter
             )))))

(describe "ede-php-autoload-drupal--filter-modules"
  (it "should filter out blacklisted paths"
    (expect
     (ede-php-autoload-drupal--filter-modules
      '(
        ;; Blacklisted paths.
        ("one" . "some/src/where")
        ("two" . "some/lib/where")
        ("three" . "some/vendor/where")
        ("four" . "some/assets/where")
        ("five" . "some/css/where")
        ("six" . "some/files/where")
        ("seven" . "some/images/where")
        ("eight" . "some/js/where")
        ("nine" . "some/misc/where")
        ("ten" . "some/templates/where")
        ("eleven" . "some/includes/where")
        ("twelve" . "some/fixtures/where")
        ("thirteen" . "some/Drupal/where")
        ("fourteen" . "some/tests/where")
        ;; These should pass through.
        ("fifteen" . "some/whitelisted/where")
        ("sixteen" . "some/another/where")
        ;; This is a special case that should not be blacklisted.
        ("seventeen" . "some/modules/config")
        ;; But this should.
        ("eighteen" . "some/config/where")
        ;; Check that they're properly caught at the beginning and end of path.
        ("nineteen" . "src/where")
        ("twenty" . "some/src")
        ;; Check that it's not too eager.
        ("twentyone" . "some/src_/where")
        ("twentyone" . "some/_src/where")))
     :to-equal
     '(("fifteen" . "some/whitelisted/where")
       ("sixteen". "some/another/where")
       ("seventeen" . "some/modules/config")
       ("twentyone" . "some/src_/where")
       ("twentyone" . "some/_src/where")))))

;;; test-functions.el ends here
