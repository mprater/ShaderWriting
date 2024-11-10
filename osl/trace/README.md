# Notice

I moved the Occlusion pattern to a new "trace" shader category to emphasize the unique characteristics of ray traced pattern generation.

## Stratified Sampling

I also added a "stratified" sampling scheme rather than using the purely random sampling described in the book.
While purely random sampling is easier to understand and implement, using stratified sampling in Monte Carlo rendering systems is a well-known means of reducing noise in the results.
This is equally true of shaders that use ray traced sampling as it is of the renderer itself.

To understand why, it's important to know that purely independent, random samples tend to "clump": samples can end up being arbitrarily close to each other.
Such samples provide little new information about the phemomenon being sampled.
Clumped samples also lead to "gaps" elsewhere in the sampling.
As such, a large number of independent, random samples will contain an equvalent number of clumped samples as it does gaps in the sample distribution.
Each of these - clumps and gaps - produce either a lack of new information, or a lack of any information at all; both of which effectively lead to fewer relevant samples, and so increase noise in the result.

Stratifed sampling aims to reduce the clumping and gaps in such purely random samples. 

Taken to the extreme, this would mean eliminating all randomness in the sampling and just using a competely regular grid of sample directions, all of which are equally spaced.
However, this introduces a new problem in that these regular samples produce visible grid artifacts in the result.
This also tends to miss features in the sampled scene that are smaller than the spacing of the sample grid. 

Stratified samping is a compromise between these the two types of sampling - purely random and completely regular - that aims to achieve the best of both.

It does this by "regularizing" or stratifying the random samples. This is achieved by starting with a "stratification" of the sample space: a regular grid.
Within each stratification cell, a random sample is placed. 
This ensures the samples are more reguarly spaced to avoid clumping and gaps, but that they are also randomized so the stratification grid itself does not become apparent in the result.

While stratified sampling is a large and complex topic, and its implementation in rendering systems is closely coupled with the random number generation methods used, the scheme I implemented in the Occlusion shader is fairly trivial. 
However, it does effectively reduce the amount of noise in the Occusion shader's result as compared to purely random samples while still being random so as to not introduce any stratification artifacts.

The initialization code first creates a perfect square of sample dimensions based on the Sample parameter's value.
It then creates a "stratum" value based on the renderer's choice of the shading sample point P.
This stratum is used to define one specific set of random values.

Within the sample loop, the index of the square stratification grid is first computed and placed in cx and cy.
Then, a uniformly distributed (equally likely to have any value from 0 to 1) random value is generated from the given stratum and cx,cy grid location and used to offset the regular grid's sample location.

The rest of the Occlusion shader is the same, except that the number of samples is the number of perfect square grid locations rather than the number specified by the Samples parameter.
