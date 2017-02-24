# These tests are written as if Drupal was installed without
# composer/installers. In real usage this doesn't make sense, but for
# testing it will suffice. 
Feature: Adding of Drupal modules to autoload

  Scenario: EDE bootstrap
    When I visit "src/main.php" in project "drupal-project"
    Then ede-php-autoload-project should exist

  Scenario: Finding a core module
    When I visit "main.php" in project "drupal-project"
    Then the class "Drupal\system\SystemClass" should be detected in "vendor/drupal/core/modules/system/src/SystemClass.php"

  Scenario: Finding a simple module
    When I visit "main.php" in project "drupal-project"
    Then the class "Drupal\simple_module\SimpleModuleClass" should be detected in "vendor/drupal/modules/simple_module/src/SimpleModuleClass.php"

  Scenario: Finding a sub module
    When I visit "main.php" in project "drupal-project"
    Then the class "Drupal\main_module\MainModuleClass" should be detected in "vendor/drupal/modules/main_module/src/MainModuleClass.php"
    Then the class "Drupal\sub_module\SubModuleClass" should be detected in "vendor/drupal/modules/main_module/sub_module/src/SubModuleClass.php"
    
  Scenario: Finding a profile module
    When I visit "main.php" in project "drupal-project"
    Then the class "Drupal\profile_module\ProfileModuleClass" should be detected in "vendor/drupal/profiles/test_profile/modules/profile_module/src/ProfileModuleClass.php"

  Scenario: Finding a site module.
    When I visit "main.php" in project "drupal-project"
    Then the class "Drupal\default_module\DefaultModuleClass" should be detected in "vendor/drupal/sites/default/modules/default_module/src/DefaultModuleClass.php"

