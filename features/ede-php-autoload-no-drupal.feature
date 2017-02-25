Feature: Testing that non-drupal works

  Scenario: EDE bootstrap
    When I visit "src/main.php" in project "non-drupal-project"
    Then ede-php-autoload-project should exist

  Scenario: Finding a core module
    When I visit "main.php" in project "non-drupal-project"
    Then the class "NonNs\NonClass" should be detected in "src/NonClass.php"
