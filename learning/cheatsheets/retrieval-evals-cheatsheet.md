---
title: "Retrieval + RAG Evaluation Cheatsheet"
summary: "Quick metrics and practices for retrieval quality and answer correctness."
type: cheatsheet
level: intermediate
topics: [rag, retrieval, evals]
updated: 2025-10-26
see_also:
  - ../reading-lists/llm-systems.md
---

## Retrieval metrics
- Recall@k: Fraction of queries with a relevant item in top-k (coverage).
- Precision@k: Fraction of top-k that are relevant (purity).
- MRR: Mean reciprocal rank of first relevant hit (position-sensitive).
- nDCG: Position-weighted gain for multiple relevant items.

## RAG answer metrics
- Faithfulness: Is the answer supported by provided sources?
- Correctness: Does it answer the question fully and accurately?
- Grounding: Are citations present and relevant?

## Practical tips
- Chunking: Balance chunk size vs overlap; test on your domain text.
- Indexing: Use embeddings suited to your content (code vs prose, multilingual).
- Re-ranking: Apply cross-encoder re-rankers for higher precision at low k.
- Negative sampling: Hard negatives improve retriever discrimination.
- Eval set: Build a representative, diverse set; avoid leakage from docs.

