# Molecular phenotype prediction and association mapping for Alzheimer's disease (AD)

This project leverages available molecular phenotype data in brains to perform TWAS for AD, in a variety of AD cohorts.

Using multi-omics data from brains for >1000 individuals, we train models for predicting from genotypes molecular phenotypes, ie, gene expression, alternative splicing, APA, methylation, histone acetylation, etc. 
We will also leverage genomic annotations obtained for different brain tissues and cell types to improve the predictions. Prediction of molecular phenotypes using models trained will be applied to 
multi-ethnic AD cohorts, to perform association testing for a number of AD related phenotypes including age at onset and cognitive memory functions.

We will also explore the possibility to predict one molecular phenotype from others and to complete missing values in these phenotypes.

To build the research website,

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

