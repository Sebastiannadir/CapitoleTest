*** Settings ***
Documentation    As a registered user
...      I want to be able to log in to the site zara.com once I accept Privacy & Terms
...      So that I can access my account and features
Resource    ./login_policy_check_step_definitions.robot
Metadata    Feature    Login Policy Check
Metadata    Caso practico evolutivo

*** Test Cases ***
Succesful Login with acceptance of terms of privacy
    [Tags]    regresionSuite
    Background
    Given I am on the login page
    ${DataTable}=    Create List
    FOR    ${User}    ${Password}    IN
    ...    pedro    12345fakepass
    ...    Juan    12345fakepass
    ...    Diego    12345fakepass
        ${entry}=    Create Dictionary    User=${User}    Password=${Password}
        Append To List    ${DataTable}    ${entry}
    END
    When I enter my username and password:    @{DataTable}
    And the user clicks the checkbox to accept the terms of privacy
    And the user clicks the "Log In" button
    Then the user is logged in to the site

Unsuccesful Login with acceptance of terms of privacy: A
    [Documentation]    Documentation for
    ...    location to be tested
    [Tags]    regresionSuite    A
    [Template]    Scenario Outline Unsuccesful Login with acceptance of terms of privacy
    https://www.ZARA.US
    https://www.ZARA.EU
    https://www.ZARA.ASIA
    https://www.ZARA.COM

Unsuccesful Login with acceptance of terms of privacy - No password: B
    [Documentation]    Documentation for
    ...    location to be tested
    [Tags]    regresionSuite    B
    [Template]    Scenario Outline Unsuccesful Login with acceptance of terms of privacy - No password
    https://www.ZARA.US
    https://www.ZARA.EU
    https://www.ZARA.ASIA
    https://www.ZARA.COM

Unsuccessful login due to locked account: C
    [Documentation]    Documentation for
    ...    location to be tested
    [Tags]    regresionSuite    C
    [Template]    Scenario Outline Unsuccessful login due to locked account
    https://www.ZARA.US
    https://www.ZARA.EU
    https://www.ZARA.ASIA
    https://www.ZARA.COM

Password reset functionality to allow the user get access to the website: D
    [Documentation]    Documentation for
    ...    location to be tested
    [Tags]    regresionSuite    D
    [Template]    Scenario Outline Password reset functionality to allow the user get access to the website
    https://www.ZARA.US
    https://www.ZARA.EU
    https://www.ZARA.ASIA
    https://www.ZARA.COM


*** Keywords ***
Background
    ${DataTable}=    Create List
    FOR    ${User}    ${Password}    IN
    ...    pedro    12345fakepass
    ...    pedro    12345fakepass
    ...    Juan    12345fakepass
    ...    Diego    12345fakepass
        ${entry}=    Create Dictionary    User=${User}    Password=${Password}
        Append To List    ${DataTable}    ${entry}
    END
    Given a new user has signed up with the following details:    @{DataTable}
    And the user has verified their email address
    And the user has logged in to their account

Scenario Outline Unsuccesful Login with acceptance of terms of privacy
    [Arguments]    ${URL}
    Background
    Given the user has an account
    When the user attempts to log in  "${URL}"
    ${DataTable}=    Create List
    FOR    ${User}    ${Password}    IN
    ...    pedro    12345fakepass
    ...    Juan    12345fakepass
    ...    Diego    12345fakepass
        ${entry}=    Create Dictionary    User=${User}    Password=${Password}
        Append To List    ${DataTable}    ${entry}
    END
    And I enter my username and password:    @{DataTable}
    And I click the "Log in" button
    Then an error message should display that says "You must accept Privacy & Terms to continue"

Scenario Outline Unsuccesful Login with acceptance of terms of privacy - No password
    [Arguments]    ${URL}
    Background
    Given the user has an account
    When the user attempts to log in  "${URL}"
    ${DataTable}=    Create List
    FOR    ${User}    ${Password}    IN
    ...    pedro    
        ${entry}=    Create Dictionary    User=${User}    Password=${Password}
        Append To List    ${DataTable}    ${entry}
    END
    And I enter my username:    @{DataTable}
    And the user clicks the checkbox to accept the terms of privacy
    And I click the "Log in" button
    Then an error message should display that says "Invalid username or password. Password is mandatory, please try again"

Scenario Outline Unsuccessful login due to locked account
    [Arguments]    ${URL}
    Background
    Given the user attempts to log in  "${URL}"
    When the user tries to log in
    And the user clicks the checkbox to accept the terms of privacy
    And I click the "Log in" button
    Then the user should see an error message indicating that their account is locked

Scenario Outline Password reset functionality to allow the user get access to the website
    [Arguments]    ${URL}
    Background
    Given the user attempts to log in  "${URL}"
    When the user clicks the "Forgot Password" link
    And enters their email address
    Then the user should receive an email with instructions for resetting their password
    And the user should be able to reset their password successfully


