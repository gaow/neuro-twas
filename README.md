# Molecular phenotype prediction and association mapping for Alzheimer's disease (AD)

This project leverages available molecular phenotype data in brains to perform TWAS for Alzheimer's Disease(AD) in various AD cohorts.

Currently, the established benchmark of TWAS analysis is the FUSION pipeline, which computes the associations between genotypes and expressions using various models and calculates the TWAS effect size using the results from the best performing one.

I have constructed two workflows. [TWAS-fusion](https://hsun3163.github.io/neuro-twas/workflow/twas_fusion.html) connects the steps for FUSION analysis into a ready-to-use pipeline. On the other hand, our implementation of TWAS analysis, multivariate susie, [mv-susie](https://hsun3163.github.io/neuro-twas/workflow/complete_mv_susie_workflow.html), can train models that predicted various molecular phenotypes, i.e., gene expression, alternative splicing, APA, methylation, histone acetylation, simultaneously.

A pilot study with ~1000 samples and three brain regions have demonstrated the performance and feasibility of mv-susie using a set of published risk locus. In two out of the three tissues, multivariate susie workflows outperform FUSION benchmark in terms of imputation accuracy for more than 40% of genes and can identify more higher number of TWAS significant genes.

A whole-genome study aiming to identify further TWAS Significant genes using more brain tissues is ongoing.

This repo containing the workflows I constructed and some analysis on the output of these workflow.

To compile the research website:
```
source jnbinder_docker.sh
jnbinder
```


## Expression data TWAS

1. RNA Seq Data transformation and QC
2. Univariate Customized weight generation (Fusion & SuSiE)
3. Multivariate weight generation (SuSiE)
4. Expression imputation (Fusion-based)
5. Association testing

