# Blog draft: Azure OpenAI model retirement (14 April 2027)

Status: **draft, not in WordPress yet.** The Elementor connector was not attached to the session
that wrote this, so the post still has to be built with Calliope (`emcp-tools-build-page`,
house template from post 4813) in a session that has `mcp__elementor-emcp__*`. Never publish;
leave it as a draft for human review.

## Post metadata

| Field | Value |
| --- | --- |
| Title | Your GPT-4o Is Retiring. A Model Swap Is Not an Upgrade Until You Have Tested It |
| Slug | `azure-openai-gpt-4o-retirement-model-migration-tokens` |
| Author | Sander Eek (ID 2), meta `author_name: "Sander Eek"` |
| Category | Microsoft update (67) |
| Tags | Azure OpenAI, Microsoft Foundry, GPT-4o, gpt-6-luna, Model retirement, Reasoning tokens, AI cost management, Model migration |
| Comments | closed |
| Spelling | British |
| Body | `body.html` (goes into the `ead-quote` text-editor widget, starts with the `<h3>`) |

## Excerpt

Microsoft retires GPT-4o, GPT-4o-mini and GPT-4.1-mini on Azure OpenAI on 14 April 2027, and
most pay-as-you-go deployments will silently switch to a reasoning model such as gpt-6-luna.
Here is what that means for quality, reasoning tokens and your bill, and how to turn model
retirement into routine servicing instead of a deadline.

## Hero image (Canva)

Saved design (default choice): https://www.canva.com/d/GQBFy5j7Rq_Judu (edit: https://www.canva.com/d/MEVuq_JBeN9FdI6)

Other candidates from the same generation job:

- https://www.canva.com/d/APkpGqS908CsOsi
- https://www.canva.com/d/WoPBoL3DlxqJMtz
- https://www.canva.com/d/fbbqn-258S_XnVD

Export as JPG 1280x720, quality 90, then sideload with alt text:
"Abstract blue illustration of an older module being swapped for a newer one in a connected system".

## Source and fact-check notes

- Source: Azure Service Health email, 6 Nov 2026, tracking ID MR5M-CG0.
- Retirement date and versions confirmed against the Microsoft Learn model retirement schedule.
- **Discrepancy:** the email names gpt-6-luna as Global/Data Zone replacement for all four models;
  Learn currently still lists gpt-5.1 for GPT-4o and no replacement for the minis. The post
  quotes the email and says Learn is expected to catch up. Re-check before publishing.
- Upgrade policy behaviour (`null` = `OnceCurrentVersionExpired`), provisioned not auto-upgraded,
  reasoning tokens billed as output, 25,000-token buffer advice, "2x or more" cost swing, capture
  not retroactive, gpt-5.1 `reasoning_effort` default `none`, cache-write charges from GPT-5.6
  onwards: all verified on Microsoft Learn.
- **Not verified:** the Azure pricing page (azure.microsoft.com was not reachable from the
  session). The post deliberately quotes no prices; the link should be checked by hand.
