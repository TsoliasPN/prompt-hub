---
title: "Transformer Intuition"
summary: "Why attention helps and how stacking layers builds understanding."
type: note
level: intermediate
topics: [llms, transformers]
updated: 2025-10-26
see_also:
  - ../reading-lists/llm-systems.md
---

## Big picture

Transformers replace recurrence with attention: each token selectively attends to others to build context-aware representations. Stacking attention + feed-forward blocks lets the model compose higher-level features.

## Core pieces

- Self-attention: Queries/Keys/Values produce weighted mixtures of token features.
- Multi-head: Parallel attention subspaces capture different relations (syntax, long-range cues, etc.).
- Positional info: Encodings inject order so attention knows where tokens sit.
- Residual + normalization: Enable deep stacks and stable training.
- Pretraining objective: Predict masked or next tokens → learn distribution of text.

## Why it works

- Content-based routing: Tokens pull exactly the context they need.
- Parallelism: No sequential dependency → efficient training and longer-range reasoning.
- Compositionality: Layers iteratively refine representations.

## Pitfalls

- Context window limits: Truncation and poor chunking hurt results.
- Spurious cues: Models may overfit patterns; prefer careful evals and ablations.
- Hallucinations: Add retrieval or constraints when faithfulness matters.

## See also

- Reading list: ../reading-lists/llm-systems.md
