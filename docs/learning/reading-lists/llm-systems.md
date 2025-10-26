---
title: "LLM Systems: Curated Overview"
summary: "High-signal resources for understanding and building LLM systems."
type: reading-list
level: intermediate
topics: [llms, systems, rag, evals, agents]
updated: 2025-10-26
see_also:
  - ../notes/transformers-intuition.md
  - ../cheatsheets/retrieval-evals-cheatsheet.md
---

Quality bar: this list stays short and opinionated. Each link includes a why-it-matters note.

## Foundations (Transformers + Attention)
- The Illustrated Transformer — Clear visuals for attention and the encoder–decoder stack. https://jalammar.github.io/illustrated-transformer/
- Attention Is All You Need (Vaswani et al., 2017) — The original Transformer paper; skim for architecture, read for intuition. https://arxiv.org/abs/1706.03762

## Prompting + Patterns
- OpenAI Cookbook — Practical prompting patterns, evaluation ideas, and tooling. https://github.com/openai/openai-cookbook
- Prompt engineering patterns (assorted guides) — Use chain-of-thought, self-consistency, and structured outputs judiciously; measure impact, don’t assume.

## RAG (Retrieval-Augmented Generation)
- Retrieval-Augmented Generation for Knowledge-Intensive NLP (Lewis et al., 2020) — The core idea and trade-offs. https://arxiv.org/abs/2005.11401
- Vector databases (docs) — Focus on indexing choices, chunking strategies, and evaluation with domain text.

## Evaluation
- IR metrics primer — Precision/Recall@k, MRR, nDCG; know how they respond to re-ranking and chunking.
- Task-specific evals — Measure faithfulness, answer correctness, and source attribution; prefer automatic + spot human audit.

## Agents + Tool Use
- Keep it simple first — Tool calling adds latency and failure modes; add only with clear ROI and guardrails.
- Monitoring + fallback — Log tool inputs/outputs, timeouts, and define safe fallbacks.

## Systems Design
- Start with evals — Define success metrics before scaling complexity.
- Observability — Capture prompts, versions, inputs, outputs, and model metadata for reproducibility.

