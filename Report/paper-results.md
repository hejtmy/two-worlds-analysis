R Notebook
================

Methods
=======

Measures
--------

We calculated participants’ walked distance in the building, time spent in each task and number of incorrectly visited doors. The conditions were not perfectly comparable in their measured distance and time, with the VR trials taking a little bit longer in both time and distance than the real world condition. We therefore min-normalised the distance traveled and the time for each task and environment by dividing the measure by any participant's performance for that trial. We calculated all statistics on these normalised measures.

There was no difference between conditions at the start of the experiment in normalised distance (*F*(2, 334)=2.11, *M**S**E* = 18.07, *p* = .123), nor in number errors (*F*(2, 363)=0.10, *M**S**E* = 64.52, *p* = .903), but there is a significant difference in normalised time (*F*(2, 363)=28.57, *M**S**E* = 24.22, *p* &lt; .001)), due to VR taking longer times to get used to (and therefore having longer normalised trial times at the start).

Participants
------------

A total of 61 (M = 20.4, SD = 2.2) undergraduate students at UC Davis particiapted in the study in exchange for a study credit. Each students was randomly assigned a condition and a randomised set of goals. 18 participants didn't finish due to motion sickness and 3 were removed due to a technical failure of the real world tracking systen. Only 58 percent the students being able to finish VR to Real world condition.

Results
=======

First we wanted to assess that there is going to be some level of transfer in all conditions. If we would assume no transfer to happen, we should observe same performance in the real world testing in 1st, 2nd and 3rd block after the switch to be similar in performance as the 1st, 2nd and 3rd block in the real world learning group. But all conditions (except desktop in distance) show better performance after the switch (see table XXX) than in the first trial, suggesting some level of transfer from all learning conditions. This is not the case with distance improvement in the desktop learning group.

| Learning condition | Distance improvement                                                         | Errors improvement                                                               |
|:-------------------|:-----------------------------------------------------------------------------|:---------------------------------------------------------------------------------|
| real-real          | *M*<sub>*d*</sub> = 1.93, 95% CI \[1.19, 2.67\], *t*(20)=5.43, *p* &lt; .001 | *M*<sub>*d*</sub> = 13.55, 95% CI \[11.88, 15.22\], *t*(21)=16.87, *p* &lt; .001 |
| ve-real            | *M*<sub>*d*</sub> = 1.09, 95% CI \[ − 0.10, 2.29\], *t*(18)=1.93, *p* = .070 | *M*<sub>*d*</sub> = 10.77, 95% CI \[8.18, 13.37\], *t*(18)=8.72, *p* &lt; .001   |
| vr-real            | *M*<sub>*d*</sub> = 2.49, 95% CI \[1.45, 3.53\], *t*(19)=5.00, *p* &lt; .001 | *M*<sub>*d*</sub> = 12.12, 95% CI \[10.62, 13.61\], *t*(19)=16.96, *p* &lt; .001 |

Looking at the progression in distance improvements and error improvements, we can see that all conditions show improvement over the experiment progression which is only hindered by the switch in the desktop learning condition (see fig. XXX and fig. XXX), but otherwise we see constant improvement unobstructed by the environemnt switch. ![](paper-results_files/figure-markdown_github/unnamed-chunk-3-1.png)![](paper-results_files/figure-markdown_github/unnamed-chunk-3-2.png)

Participant's performance in the first pre-switch phase shows different rates of learning rate for errors for our learning conditions (see table XX). There is no significant difference between different modalities in distance performance before the switch *F*(2, 321)=2.88, *M**S**E* = 4.24, *p* = .058, $\\hat{\\eta}^2\_G = .018$, but the performance across groups differs in errors *F*(2, 363)=32.63, *M**S**E* = 22.37, *p* &lt; .001, $\\hat{\\eta}^2\_G = .152$.

| Predictor                         | Significance for distance improvement | Significance for error improvement | names                                  |
|:----------------------------------|:--------------------------------------|:-----------------------------------|:---------------------------------------|
| (Intercept)                       | p &lt; .001                           | p &lt; .001                        | Intercept                              |
| exp\_block\_id                    | p &lt; .001                           | p &lt; .001                        | Block number                           |
| learning.condition                | p = 0.18                              | p = 0.18                           | Learning condition                     |
| learning.condition:exp\_block\_id | p = 0.72                              | p = 0.72                           | Block - Learning condition interaction |

### After modality switch performance change

Anova doesn't show shows a significant difference between groups in the block 3 (*F*(2, 321)=2.88, *M**S**E* = 4.24, *p* = .058), but there is a significant difference between distance performance in the block 4 (*F*(2, 295)=3.86, *M**S**E* = 5.50, *p* = .022).

After the switch, we can see a significant difference between distance performance (*F*(2, 295)=3.86, *M**S**E* = 5.50, *p* = .022) and errors as well (*F*(2, 363)=13.15, *M**S**E* = 19.79, *p* &lt; .001), with groups learning on the treadmill or desktop performing worse than those learning in the real world.

Mixed effect models with individual random effect show significant effect of the of the learning condition on rate of improvement from phase 1 to pahase 2 (See table XXX )

| Predictor                         | Significance for distance improvement | Significance for error improvement | names                                  |
|:----------------------------------|:--------------------------------------|:-----------------------------------|:---------------------------------------|
| (Intercept)                       | p = 0.4                               | p = 0.4                            | Intercept                              |
| exp\_block\_id                    | p &lt; .001                           | p &lt; .001                        | Block number                           |
| learning.condition                | p = 0.08                              | p = 0.08                           | Learning condition                     |
| learning.condition:exp\_block\_id | p = 0.05                              | p = 0.05                           | Block - Learning condition interaction |

Running separate pairwise t-tests to see individual performance change from block 3 to 4 gives the following results.

| learning condition |  p-value distance improvement|  p-value errors improvement|
|:-------------------|-----------------------------:|---------------------------:|
| real-real          |                     0.8758327|                   0.0182545|
| ve-real            |                     0.0540446|                   0.0254278|
| vr-real            |                     0.9100385|                   0.0000096|

We can see that all participants improved in the errors made, but neigher group is significantly worse between block 3 and 4 in the path travelled (although participants learning on desktop perform slightly worse in 4th block, but the significance is only marginal)

### Personal

To assess the level of performance change form directly before and after the switch, we calculated personal improvement as (block3-block4)/(block3+block4)´.

![](paper-results_files/figure-markdown_github/unnamed-chunk-7-1.png)![](paper-results_files/figure-markdown_github/unnamed-chunk-7-2.png)

Comparing the block perfomance change in different conditions using anovas, we see marginally significant difference in the improvement between groups for distance (*F*(2, 58)=2.77, *M**S**E* = 0.06, *p* = .071), but we see significant differences in error rate improvement (*F*(2, 49)=6.72, *M**S**E* = 0.13, *p* = .003). This is consistent with the mixed models which poited at interaction between block and learning condition.

Tukey post-hoc tests show significant difference between error rate improvement between the group that leardned in the real world and that which learned on the desktop.

|                      |        diff| p-value     |
|----------------------|-----------:|:------------|
| Real-Desktop         |   0.4710119| p &lt; .001 |
| Treadmill VR-Desktop |   0.2298740| p = 0.12    |
| Treadmill VR-Real    |  -0.2411379| p = 0.15    |
