Feature: Login Policy Check

  As a registered user
  I want to be able to log in to the site zara.com once I accept Privacy & Terms
  So that I can access my account and features

  Background:
    Given a new user has signed up with the following details:
      | User        | Password      |
      | pedro       | 12345fakepass |
      | pedro       | 12345fakepass |
      | Juan        | 12345fakepass |
      | Diego       | 12345fakepass |
  And the user has verified their email address
  And the user has logged in to their account

  @regresionSuite
  Scenario: Succesful Login with acceptance of terms of privacy
    Given I am on the login page
    When I enter my username and password:
      | User        | Password        |
      | pedro       | 12345fakepass   |
      | Juan        | 12345fakepass   |
      | Diego       | 12345fakepass   |
    And the user clicks the checkbox to accept the terms of privacy
    And the user clicks the "Log In" button
    Then the user is logged in to the site

  @regresionSuite
  Scenario Outline: Unsuccesful Login with acceptance of terms of privacy
    Given the user has an account
    When the user attempts to log in  "<URL>"
    And I enter my username and password:
      | User        | Password        |
      | pedro       | 12345fakepass   |
      | Juan        | 12345fakepass   |
      | Diego       | 12345fakepass   |
    And I click the "Log in" button
    Then an error message should display that says "You must accept Privacy & Terms to continue"

    @A
    Examples: A
      Documentation for
      location to be tested
      | URL  | Continente |
      | https://www.ZARA.US      | EEUU    |
      | https://www.ZARA.EU      | Europa  |
      | https://www.ZARA.ASIA    | Asia    |
      | https://www.ZARA.COM     | America |
      #add list of urls to be tested - 10 countries

  @regresionSuite
  Scenario Outline: Unsuccesful Login with acceptance of terms of privacy - No password
    Given the user has an account
    When the user attempts to log in  "<URL>"
    And I enter my username:
      | User        | Password        |
      | pedro       |                 |
    And the user clicks the checkbox to accept the terms of privacy
    And I click the "Log in" button
    Then an error message should display that says "Invalid username or password. Password is mandatory, please try again"

    @B
    Examples: B
      Documentation for
      location to be tested
      | URL  | Continente |
      | https://www.ZARA.US      | EEUU    |
      | https://www.ZARA.EU      | Europa  |
      | https://www.ZARA.ASIA    | Asia    |
      | https://www.ZARA.COM     | America |
      #add list of urls to be tested - 10 countries

  @regresionSuite
  Scenario Outline: Unsuccessful login due to locked account
    Given the user attempts to log in  "<URL>"
    When the user tries to log in
    And the user clicks the checkbox to accept the terms of privacy
    And I click the "Log in" button
    Then the user should see an error message indicating that their account is locked

    @C
    Examples: C
      Documentation for
      location to be tested
      | URL  | Continente |
      | https://www.ZARA.US      | EEUU    |
      | https://www.ZARA.EU      | Europa  |
      | https://www.ZARA.ASIA    | Asia    |
      | https://www.ZARA.COM     | America |
      #add list of urls to be tested - 10 countries

  @regresionSuite
  Scenario Outline: Password reset functionality to allow the user get access to the website
    Given the user attempts to log in  "<URL>"
    When the user clicks the "Forgot Password" link
    And enters their email address
    Then the user should receive an email with instructions for resetting their password
    And the user should be able to reset their password successfully

    @D
    Examples: D
      Documentation for
      location to be tested
      | URL  | Continente |
      | https://www.ZARA.US      | EEUU    |
      | https://www.ZARA.EU      | Europa  |
      | https://www.ZARA.ASIA    | Asia    |
      | https://www.ZARA.COM     | America |
      #add list of urls to be tested - 10 countries