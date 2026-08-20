## Why

RLP audit: CSP initializer is a commented stub (no policy enforced). Auth uses cookie `session[:user_id]` with no idle or absolute timeout model. Other audit findings (impersonation, sync, imports, API tokens) do not apply.

## What Changes

- Enable and enforce a Content-Security-Policy with nonces suitable for Hotwire/importmap.
- Introduce idle session timeout (default 30 days) and absolute max lifetime (7 days) for signed-in users, terminating stale cookie sessions.

## Capabilities

### New Capabilities
- `security-baseline`: Enforced CSP and cookie-session idle + absolute expiry.

### Modified Capabilities

## Non-goals

- Impersonation, API tokens, file imports, PWA sync CSRF, inbound email → content.
- Migrating to a DB `Session` model unless needed for absolute expiry tracking (cookie timestamp approach is acceptable).

## Impact

- `config/initializers/content_security_policy.rb`
- `ApplicationController` (or sessions concern) session expiry checks
- Possible signed cookie / `session[:signed_in_at]` / `session[:last_activity_at]` fields

## Review gate

**Human review** of idle timeout choice for this app’s usage pattern before production.
