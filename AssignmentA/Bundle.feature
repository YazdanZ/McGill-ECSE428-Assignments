Feature: Create and Manage Listings of Textbook Bundles

    As a seller, I want to create and manage listings of textbook bundles, so that I can sell multiple textbooks together and simplify the selling process.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
        And the following textbooks exist:
            | Title                            | Author       | Condition  | seller  |
            | "Introduction to Algorithms"     | "Stewart"    | "Good"     | "jdoe"  |
            | "Data Structures and Algorithms" | "Van Rossum" | "Like new" | "jdoe"  |
            | "Operating Systems"              | "Johnson"    | "Fair"     | "jdoe"  |
            | "C++ Programming"                | "Stroustrup" | "New"      | "awang" |
        And I am logged in with username "jdoe" with password "jdoepass"

    Scenario: Create a Listing for a Textbook Bundle
        Given I have textbooks to sell
        When I create a listing for a bundle of textbooks with the following details:
            | Bundle Name | "Computer Science Major Bundle"  |
            | Condition   | "Used - Like New"                |
            | Price       | "$150"                           |
            | Textbook 1  | "Introduction to Algorithms"     |
            | Textbook 2  | "Data Structures and Algorithms" |
            | Textbook 3  | "Operating Systems"              |
        And I possess all the textbooks listed in the bundle
        Then the bundle listing is created successfully
        And the listing is displayed on the listings page
        And the number of bundle listings in the system is "1"
        And the bundle listing contains the correct information

    Scenario: Edit a Listing for a Textbook Bundle
        Given I have an existing listing for a bundle of textbooks with the following details:
            | Bundle Name | "Computer Science Major Bundle"  |
            | Condition   | "Used - Like New"                |
            | Price       | "$150"                           |
            | Textbook 1  | "Introduction to Algorithms"     |
            | Textbook 2  | "Data Structures and Algorithms" |
            | Textbook 3  | "Operating Systems"              |
        When I edit the listing to have the following details:
            | Bundle Name | "Computer Science Books"         |
            | Condition   | "Used - Good"                    |
            | Price       | "$120"                           |
            | Textbook 1  | "Introduction to Algorithms"     |
            | Textbook 2  | "Data Structures and Algorithms" |
        Then the listing shall be updated successfully
        And the listing is displayed on the listings page
        And the bundle listing contains the correct information

    Scenario: Delete a Listing for a Textbook Bundle
        Given I have an existing listing for a bundle of textbooks with the following details:
            | Bundle Name | "Computer Science Major Bundle"  |
            | Condition   | "Used - Like New"                |
            | Price       | "$150"                           |
            | Textbook 1  | "Introduction to Algorithms"     |
            | Textbook 2  | "Data Structures and Algorithms" |
            | Textbook 3  | "Operating Systems"              |
        When I delete the listing
        Then the listing is deleted successfully
        And the listing is no longer displayed on the listings page
        And the number of nundle listings in the system is "0"

    Scenario: View a Listing for a Textbook Bundle
        Given there is a listing for a bundle of textbooks with the following details:
            | Bundle Name | "Computer Science Major Bundle"  |
            | Condition   | "Used - Like New"                |
            | Price       | "$150"                           |
            | Textbook 1  | "Introduction to Algorithms"     |
            | Textbook 2  | "Data Structures and Algorithms" |
            | Textbook 3  | "Operating Systems"              |
        When I view the listing
        Then the listing is displayed with the correct information

    Scenario: Missing information in bundle creation
        Given I have a bundle of textbooks to sell
        When I create a listing for a bundle of textbooks with missing information:
            | Bundle Name | "Computer Science Major Bundle"  |
            | Condition   | "Used - Like New"                |
            | Price       |                                  |
            | Textbook 1  |                                  |
            | Textbook 2  | "Data Structures and Algorithms" |
            | Textbook 3  | "Operating Systems"              |
        Then the listing is not created in the system
        And I shall receive the error "One of more mandatory fields are missing"


    Scenario: Missing information in bundle creation
        Given I have an existing listing for a bundle of textbooks with the following details:
            | Bundle Name | "Computer Science Major Bundle"  |
            | Condition   | "Used - Like New"                |
            | Price       | "$150"                           |
            | Textbook 1  | "Introduction to Algorithms"     |
            | Textbook 2  | "Data Structures and Algorithms" |
            | Textbook 3  | "Operating Systems"              |
        When I update my existing listing for a bundle of textbooks with missing information:
            | Bundle Name | "Computer Science Major Bundle"  |
            | Condition   | "Used - Like New"                |
            | Price       |                                  |
            | Textbook 1  |                                  |
            | Textbook 2  | "Data Structures and Algorithms" |
            | Textbook 3  | "Operating Systems"              |
        Then the listing is not updated in the system
        And I shall receive the error "One of more mandatory fields are missing"

    Scenario: Seller creates bundle with only one textbook
        When I create a listing for a bundle of textbooks with the following details:
            | Bundle Name | "Computer Science Major Bundle" |
            | Condition   | "Used - Like New"               |
            | Price       | "$150"                          |
            | Textbook 1  | "Introduction to Algorithms"    |
        Then the system should display an error message "A bundle must contain at least two textbooks"
        And the bundle shall not be added to the system




