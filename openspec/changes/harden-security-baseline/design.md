## Context

No DB Session model; `session[:user_id]` cookie auth. CSP file is Rails stub (commented). No impersonation controllers.

## Goals / Non-Goals

**Goals:** Enforce CSP; add idle + absolute session lifetime.

**Non-Goals:** Full SaaS auth rewrite; impersonation.

## Decisions

### Session tracking without DB Session
- Store `session[:authenticated_at]` at login and `session[:last_activity_at]` updated per request.
- Expire when idle > 30 days OR age > 7 days; clear session and require login.

### CSP
- Uncomment/enable enforced policy; nonces for scripts; avoid `unsafe_eval`.

## Risks / Trade-offs

- Cookie-only absolute expiry resets if session store is cleared; acceptable for this app.
