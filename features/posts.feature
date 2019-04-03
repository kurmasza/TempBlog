Feature: Posts

  Scenario: Visiting post page
    When I visit the posts page
    Then I should see all "2" posts

  Scenario: Creating a new post
    When I visit the posts page
    And I click on "New Post"
    Then I should see the new post form

    When I fill in and submit the New Post form
    Then I should see the Post Created page

    When I click on "Back"
    Then I should see all "3" posts
    And I should see "War and Peace"