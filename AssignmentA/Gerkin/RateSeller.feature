Feature: Rate Sellers

    As a student buyer, I want to be able to rate sellers on the platform so that I can help other buyers make informed decisions.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | chen     | chen21   | student seller |
            | y        | y12      | student buyer  |

        And  the following listings exist:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jdoe"          |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |
        And the following ratings/reviws exist:
            | Rater | Seller | rating score | review comment |
            | y     | chen   | 3            | Rude           |


        Given I am logged in as a user "jsmith" with password "jsmithp"

    Scenario: Successfully rate a seller
        When I attempt to rate a seller "jdoe" I have brought the textbok "Organic Chemistry" from.
        And I enter a rating score "3" and a review comment "Slow shipping"
        Then I should see a confirmation message that my rating has been recorded
        And my rating history shall be updated:
            | Rater  | Seller | rating score | review comment |
            | jsmith | jdoe   | 3            | Slow shipping  |

    Scenario: View seller ratings:
        When I attempt to view the ratings for seller "chen21"
        Then I shall see reviews given to her by any user:
            | Rater | Seller | rating score | review comment |
            | y     | chen   | 3            | Rude           |


    Scenario: Attempt to rate a seller without a rating score
        When I attempt to rate a seller "jdoe" I have brought the textbok "Organic Chemistry" from.
        And I enter a review comment "Slow shipping"
        But do not enter a rating score
        Then I shall see an error message "rating score is required"
        And my rating history shall not be updated



    Scenario: Attempt to rate a seller without a review comment
        When I attempt to rate a seller "jdoe" I have brought the textbok "Organic Chemistry" from.
        And I enter a rating score of "3"
        But do not enter a review comment
        Then I should see a confirmation message that my rating has been recorded without comment
        And my rating history shall be updated:
            | Rater  | Seller | rating score | review comment |
            | jsmith | jdoe   | 3            |                |

    Scenario: Attempt to rate a seller I have not bought from
        Given I have not bought any textbooks from seller "chen"
        When I attempt to rate "chen"
        And I enter a valid rating score and a review comment
        Then I should see the error message "cannot rate a seller you haven't bought from"

    Scenario: Attempt to rate a seller more than once
        Given I have previously rate seller "jdoe":
            | Rater  | Seller | rating score | review comment |
            | jsmith | jdoe   | 3            | Slow shipping  |

        When I attempt to rate a seller "jdoe" I have brought the textbok "Organic Chemistry" from.
        And I enter a rating score of "4" and a review comment "not bad"
        Then I shall see an error "You have already rated the seller"
        And my rating history shall not be updated:
            | Rater  | Seller | rating score | review comment |
            | jsmith | jdoe   | 3            |                |
