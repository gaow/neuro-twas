For each genes, the Z score after TWAS are noted as $Z_{\text{twas}}$,

$$\mathbf{Z}_{\mathbf{\text{twas}}} = \frac{\mathbf{W}\mathbf{Z}_{\mathbf{\text{gwas}}}}{\sqrt{\mathbf{\text{Var}}\left( {\mathbf{W}\mathbf{Z}}_{\mathbf{\text{gwas}}} \right)}}\mathbf{=}\frac{\mathbf{W}\mathbf{Z}_{\mathbf{\text{gwas}}}}{\sqrt{\mathbf{W*Var}\left( \mathbf{Z}_{\mathbf{\text{gwas}}} \right)\mathbf{*}\mathbf{W}^{\mathbf{T}}}}$$

Where **W** is
$\mathbf{\Sigma}_{\mathbf{e,s}}\mathbf{\Sigma}_{\mathbf{s,s}}^{\mathbf{- 1}}$**,**
$\mathbf{\Sigma}_{\mathbf{e,s}}$ is the covariate matrix between SNP and
gene expression, which are populated by various different algorithm in
Fusion_Weight_Compute.R. $\mathbf{\Sigma}_{\mathbf{s,s}}^{}$ is the LD
matrix for all SNPs.

$\mathbf{Z}_{\mathbf{\text{gwas}}}$ *is a vector of N elements
containing the GWAS association statistics for each of the SNP of said
genes* $\mathbf{Z}_{\mathbf{j,}\mathbf{\text{gwas}}}$

$$\mathbf{Z}_{\mathbf{j}\mathbf{,}\mathbf{\text{gwas}}}\mathbf{=}\frac{\beta_{j,gwas}}{\text{SE}\left( \beta_{j,gwas} \right)}$$

*The exact components that specify*
$\mathbf{Z}_{\mathbf{j}\mathbf{,}\mathbf{\text{gwas}}}$ *vary based on
how* $\beta$ *was estimated, under the case of GWAS between one SNP and
the phenotype,*

$$\beta_{j,gwas} = \frac{X_{j}^{T}y}{{X_{j}}^{T}X_{j}}\text{\ \ }$$

$$\text{SE}\left( \beta_{j,gwas} \right) = \sqrt{\frac{\left( \text{Var}\left( y \right) - Var\left( X_{j} \right)*\ \beta_{j,gwas}^{2}\  \right)}{{Var(X}_{j})*N}}$$

*Where* $y$ *is the phenotype of interests, N is the total number of
SNP, and* $\mathbf{X}_{\mathbf{j}}$*is the a vector of the population
base mean centered genotype for the*$\ j^{\text{th}}$ *SNP corresponding
to* $y$*.*

*With the assumption that*
$\mathbf{Z}_{\mathbf{\text{gwas}}}\sim N(0\mathbf{,}\Sigma_{s,s})$*,
this bring the full model into:*

$$Z_{\text{twas}}\mathbf{=}\frac{\mathbf{\Sigma}_{\mathbf{e,s}}\mathbf{\Sigma}_{\mathbf{s}\mathbf{,}\mathbf{s}}^{\mathbf{- 1}}\left\{ \frac{\frac{X_{j}^{T}y}{{X_{j}}^{T}X_{j}}}{\sqrt{\frac{\left( \text{Var}\left( y \right) - Var\left( \mathbf{X}_{\mathbf{j}} \right)*\left( \frac{\mathbf{X}_{\mathbf{j}}^{\mathbf{T}}y}{{\mathbf{X}_{\mathbf{j}}}^{\mathbf{T}}\mathbf{X}_{\mathbf{j}}} \right)^{2}\  \right)}{{Var(\mathbf{X}}_{j})*N}}} \right\}}{\sqrt{\mathbf{\Sigma}_{\mathbf{e,s}}\mathbf{\Sigma}_{\mathbf{s}\mathbf{,}\mathbf{s}}^{\mathbf{- 1}}\mathbf{*}\mathbf{\Sigma}_{\mathbf{s,s}}\mathbf{*}\left( \mathbf{\Sigma}_{\mathbf{e,s}}\mathbf{\Sigma}_{\mathbf{s}\mathbf{,}\mathbf{s}}^{\mathbf{- 1}} \right)^{\mathbf{T}}}}$$

Under further assumptions that

1.  Each SNP only explained negligible portion of the total variance,
    $\text{Var}\left( \mathbf{X}_{\mathbf{j}} \right)*\left( \frac{\mathbf{X}_{\mathbf{j}}^{\mathbf{T}}y}{{\mathbf{X}_{\mathbf{j}}}^{\mathbf{T}}\mathbf{X}_{\mathbf{j}}} \right)^{2} \approx 0$

2.  Phenotypes assumed to be Var(y) = 1

3.  Genotypes are standardized such that Var($X_{j}$) = 1

$$Z_{\text{twas}}\mathbf{=}\frac{\mathbf{\Sigma}_{\mathbf{e,s}}\mathbf{\Sigma}_{\mathbf{s}\mathbf{,}\mathbf{s}}^{\mathbf{- 1}}\left\{ \left( \frac{\mathbf{X}_{\mathbf{j}}^{\mathbf{T}}y}{{\mathbf{X}_{\mathbf{j}}}^{\mathbf{T}}\mathbf{X}_{\mathbf{j}}} \right)\mathbf{*}\sqrt{N} \right\}}{\sqrt{\mathbf{\Sigma}_{\mathbf{e,s}}\mathbf{\Sigma}_{\mathbf{s}\mathbf{,}\mathbf{s}}^{\mathbf{- 1}}\mathbf{*}\mathbf{\Sigma}_{\mathbf{s,s}}\mathbf{*}\left( \mathbf{\Sigma}_{\mathbf{e,s}}\mathbf{\Sigma}_{\mathbf{s}\mathbf{,}\mathbf{s}}^{\mathbf{- 1}} \right)^{\mathbf{T}}}}$$
