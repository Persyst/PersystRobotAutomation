*** Settings ***
Resource    Info.robot
Resource    PerformanceAES2024.robot
Test Template       Run all 3 tests
Suite Setup          Run Keywords     Begin Web Suit With No Login
Suite Teardown        End Web Suit

*** Test Cases ***
Run Test With User
#    @{USERS}  # This pulls all 50 usernames from the `users.robot` file
     ${USERS}[0]
     ${USERS}[1]
