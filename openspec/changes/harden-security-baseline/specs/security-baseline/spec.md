## Purpose

Give Presidential Fitness an enforced Content Security Policy and explicit idle plus absolute session lifetimes for cookie-based authentication.

## ADDED Requirements

### Requirement: CSP is enabled and enforced
The application SHALL send an enforced Content-Security-Policy header.

#### Scenario: HTML responses include enforced CSP
- **GIVEN** production-like configuration
- **WHEN** an HTML page is served
- **THEN** a Content-Security-Policy header is present and enforced

### Requirement: Cookie session idle and absolute lifetime
Signed-in cookie sessions SHALL expire after 30 days of inactivity OR 7 days after authentication, whichever comes first.

#### Scenario: Absolute lifetime forces re-login
- **GIVEN** a session authenticated more than 7 days ago that was recently active
- **WHEN** the user makes a request
- **THEN** the session is cleared and re-authentication is required

#### Scenario: Idle timeout forces re-login
- **GIVEN** a session with no activity for more than 30 days
- **WHEN** the user makes a request
- **THEN** the session is cleared and re-authentication is required
