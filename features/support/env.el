;;; Commentary: Originally stolen from ede-php-autoload and adapted.
(require 'package)
(require 'f)
(require 'cl-lib)
(require 'ert)
(require 'eieio)
(require 'ede-php-autoload)

(defvar ede-php-autoload-drupal-support-path
  (f-dirname load-file-name))

(defvar ede-php-autoload-drupal-features-path
  (f-parent ede-php-autoload-drupal-support-path))

(defvar ede-php-autoload-drupal-root-path
  (f-parent ede-php-autoload-drupal-features-path))

(defvar ede-php-autoload-drupal-test-projects-root-path
  (f-join ede-php-autoload-drupal-root-path "fixtures"))

(defun ede-php-autoload-drupal-test-get-project-file-path (file project)
  "Return the absolute path for FILE relative to PROJECT."
  (f-join ede-php-autoload-drupal-test-projects-root-path project file))

(defun ede-php-autoload-drupal-test-get-current-project-name ()
  "Return the test project currently visited."
  (car
   (f-split
    (f-relative
     (or (buffer-file-name) default-directory)
     ede-php-autoload-drupal-test-projects-root-path))))

(add-to-list 'load-path ede-php-autoload-drupal-root-path)

(package-generate-autoloads "ede-php-autoload-drupal" ede-php-autoload-drupal-root-path)
(load (f-join ede-php-autoload-drupal-root-path "ede-php-autoload-drupal-autoloads.el"))

(Setup
 (require 'ede-php-autoload-drupal)
 (global-ede-mode 1))
