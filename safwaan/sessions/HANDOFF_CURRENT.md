# Handoff — SQL Track Kickoff

## Context

SQL learning track scaffolded on 2026-06-16, mirroring the structure of the `algorithms/` DSA track (same coach, same learner, separate curriculum/tracker so the two don't collide). No problems attempted yet.

## What Was Just Completed

Scaffolding only:
- `CURRICULUM.md` — 10 phases, 58 problems, SELECT basics → joins → subqueries → window functions → mixed hard practice
- `TRACKER.md` — all 58 problems listed, all ⏳ not started
- `CLAUDE.md` — coaching instructions adapted from the DSA track (NULL-handling and WHERE-vs-HAVING flagged as likely early friction points; window functions flagged as needing a trace-table approach similar to what worked for bit-shift confusion in DSA)
- `safwaan/` profile files initialized empty
- `queries/` folder created for per-problem work

## Next Session — Start Here

Start cold on **Phase 1, #1 — Combine Two Tables (LC #175)**. It's about as gentle an opener as SQL gets (LEFT JOIN + SELECT), good for establishing baseline before anything harder.

## Safwaan's Current State

**What he knows:** Unknown for SQL specifically. Strong DSA fundamentals and general learning style carry over (bottom-up thinker, learns from concrete traces, strong metacognition) — see `algorithms/safwaan/identity.md` for the general profile, but don't assume SQL intuition transfers from algorithmic thinking.

**Gaps to probe:** None identified yet — first session will surface real signal.

## Coach Notes

- This is a brand-new track. Don't carry over DSA-specific calibration as fact — treat the first 2-3 SQL sessions as discovery, and update CLAUDE.md's Expertise Calibration section once real patterns show up.
- Watch for NULL handling and WHERE-vs-HAVING confusion early — these are the two most common universal SQL beginner traps and Phase 1/3 are designed to surface them.
