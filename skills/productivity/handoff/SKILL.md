---
name: handoff
description: Compact the current conversation into a handoff document for another agent to pick up.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Run the following steps in order, without skipping any:

1. **Use the Write tool to save a handoff markdown file** to the system's temporary directory (`/tmp/handoff-<topic>.md` or `%TEMP%/handoff-<topic>.md`). Do not save it to the current workspace.

2. Use the following template:

   ```markdown
   # Handoff: <topic>

   ## Summary

   What was accomplished in this session. 2-3 sentences.

   ## Completed

   - Bullet list of what was done

   ## In Progress / Next Steps

   - What the next agent should work on

   ## Suggested Skills

   - Which skills the next agent should call the Skill tool for (e.g. `/to-spec`, `/implement`)

   ## Artifacts

   - Reference to existing files by path or URL (do not duplicate content already captured in specs, plans, ADRs, issues, commits, diffs)
   ```

3. **Redact** any sensitive information (API keys, passwords, PII).

4. If the user passed arguments, treat them as a description of what the next session will focus on and tailor the doc accordingly.

5. **Report the file path** to the user.