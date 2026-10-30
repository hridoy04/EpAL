
# EpAL: single-sequence, substitution-level antigenicity prediction for viral glycoproteins

**EpAL** (Epistasis-aware Antigenicity prediction using a protein Language model) estimates how antigenic each possible amino-acid substitution in a viral glycoprotein is, starting from a single sequence. It needs no multiple-sequence alignment and no resolved structure, so it can be applied at the start of an outbreak, when neither exists.

> **Status:** code accompanying a manuscript in preparation. Installation and usage instructions will be added. [Add preprint or journal link when available.]

![Workflow](https://github.com/hridoy04/EpAL/blob/master/ppt_fig1_v2.jpg)

## Concept

Residue-level epitope predictors such as SEMA-2 give each site a single antigenicity score. Escape, however, is caused by specific substitutions, and a site-level score ranks all 19 substitutions at a site identically. EpAL works at the level of the individual substitution:

1. **In silico deep mutational scanning.** From one reference sequence, generate all 19 possible substitutions at every site.
2. **Substitution-level antigenicity.** Run SEMA-2 (1D) on each mutant sequence to estimate predicted antibody-contact propensity.
3. **Linked sites.** For each substitution, use ESM-2 (650M) to find sites whose predicted amino-acid probabilities shift significantly. These sites are a model-derived proxy for residues coupled to the substituted site. They are not a measurement of the residues that interact in antibody binding.
4. **EpAL score.** Average the SEMA-2 antigenicity of the linked sites for each substitution.

Two further criteria help prioritize candidate substitutions: the ESM-2 amino-acid likelihood, as a proxy for structural compatibility, and predicted relative surface accessibility [tool: confirm].

The contribution of the linked sites is tested directly by comparing EpAL with SEMA-2 applied to each mutant without them. N-glycosylation predicted by SEMA-2 was examined as a post hoc sensitivity analysis and is not part of the score.

## Evaluation

EpAL was benchmarked on literature-curated antibody-escape substitutions in HIV-1 Env, SARS-CoV-2 Spike and influenza A (H1N1) hemagglutinin. Comparators were experimental deep mutational scanning, EVEscape, a semantic score from ESM-2, ESM-2 likelihoods, and SEMA-2 without linked sites. Results are reported in the manuscript.

## Application

The framework was applied to glycoproteins of viruses with few sequences or recent outbreaks: Borna disease virus 1 (BoDV-1) p57, Crimean-Congo hemorrhagic fever virus (CCHFV) GPC, Marburg virus (MARV) GP1,2, Andes virus (ANDV) Gn/Gc and Bundibugyo virus (BDBV) GP1,2. Outputs are candidate epitopes and substitutions for experimental testing. They are hypotheses, not validated escape mutations.

## Limitations

- SEMA-2 predicts antibody-contact propensity, which is not binding affinity or measured escape.
- Linked sites come from a language model trained on evolutionary data, so they are a proxy.
- Surface accessibility is predicted from monomeric sequence and may not reflect oligomeric context.
- O-glycosylation and glycan shielding are not modelled.

## Authors

A S M Rubayet Ul Alam, Kieran Lamb, Oscar MacLean, Ke Yuan, Joseph Hughes and David L Robertson, MRC-University of Glasgow Centre for Virus Research.
