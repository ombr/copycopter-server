Feature: create blurbs

  Background:
    Given a project exists with a name of "Project 1"

  @javascript
  Scenario: create a blurb
    Given the following localizations exist in the "Project 1" project:
      | key      |
      | test.key |
    When I go to the blurbs index for the "Project 1" project
    And I type "anewkey" into "Search"
    And I follow "Create the key"
    Then the following blurb should exist in the "Project 1" project:
      | anewkey  |

  @javascript
  Scenario: Perform a search with no results
    Given the following localizations exist in the "Project 1" project:
      | key      |
      | test.key |
    When I go to the blurbs index for the "Project 1" project
    Then no visible elements should contain "No results"
    When I type "find" into "Search"
    Then a visible element should contain "No results"
    When I clear the "Search" field
    And I type "test" into "Search"
    Then no visible elements should contain "No results"
