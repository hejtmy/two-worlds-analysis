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

First we wanted to assess that there is going to be some level of transfer in all conditions. If we would assume no transfer to happen, we should observe same performance in the real world testing in 1st, 2nd and 3rd block after the switch to be similar in performance as the 1st, 2nd and 3rd block in the real world learning group. But all conditions (except desktop in distance) show better performance after the switch (see table XXX) than in the first trial, suggesting some level of transfer happening in all learning conditions.

| Learning condition | Distance improvement                                                         | Errors improvement                                                               |
|:-------------------|:-----------------------------------------------------------------------------|:---------------------------------------------------------------------------------|
| Real               | *M*<sub>*d*</sub> = 1.93, 95% CI \[1.19, 2.67\], *t*(20)=5.43, *p* &lt; .001 | *M*<sub>*d*</sub> = 13.55, 95% CI \[11.88, 15.22\], *t*(21)=16.87, *p* &lt; .001 |
| Desktop            | *M*<sub>*d*</sub> = 1.09, 95% CI \[ − 0.10, 2.29\], *t*(18)=1.93, *p* = .070 | *M*<sub>*d*</sub> = 10.77, 95% CI \[8.18, 13.37\], *t*(18)=8.72, *p* &lt; .001   |
| Treadmill VR       | *M*<sub>*d*</sub> = 2.49, 95% CI \[1.45, 3.53\], *t*(19)=5.00, *p* &lt; .001 | *M*<sub>*d*</sub> = 12.12, 95% CI \[10.62, 13.61\], *t*(19)=16.96, *p* &lt; .001 |

Looking at the progression in distance improvements and error improvements over the course of the experiment, we can see that all conditions show progressive improvement which is only hindered by the switch in the desktop learning condition (see fig. XXX and fig. XXX), but in the Treadmill condition we see constant improvement unobstructed by the environmrnt switch. ![](paper-results_files/figure-markdown_github/unnamed-chunk-3-1.png)![](paper-results_files/figure-markdown_github/unnamed-chunk-3-2.png)

Participant's performance in the first pre-switch phase shows different rates of learning rate, demonstrated by an interaction between block bumber and learning condition for error rate performance (see table XX).

| Predictor                              | Significance for distance improvement | Significance for error improvement |
|:---------------------------------------|:--------------------------------------|:-----------------------------------|
| Intercept                              | p &lt; .001                           | p &lt; .001                        |
| Block number                           | p &lt; .001                           | p &lt; .001                        |
| Learning condition                     | p = 0.18                              | p = 0.65                           |
| Block - Learning condition interaction | p = 0.72                              | p &lt; .001                        |

### After modality switch performance change

We found no significant difference between different modalities in distance performance before the switch (although are marginally significnat suggetsting there might be some difference) *F*(2, 321)=2.88, *M**S**E* = 4.24, *p* = .058, but the error rate in the pre-switch block differs across groups *F*(2, 363)=32.63, *M**S**E* = 22.37, *p* &lt; .001.

After the modality switch, we can see a significant difference between distance performance (*F*(2, 295)=3.86, *M**S**E* = 5.50, *p* = .022) and errors as well (*F*(2, 363)=13.15, *M**S**E* = 19.79, *p* &lt; .001), with groups learning on the treadmill or desktop performing worse than those learning in the real world. This difference post-switch is still apparent in the 2nd block after the switch (block 5) in error rate *F*(2, 363)=6.75, *M**S**E* = 6.86, *p* = .001 and marginally in distance *F*(2, 256)=2.87, *M**S**E* = 0.37, *p* = .058. In the last testing block (block 6), we found no differences among the groups in either error rate *F*(2, 363)=1.67, *M**S**E* = 3.33, *p* = .191 nor distance *F*(2, 258)=1.95, *M**S**E* = 0.28, *p* = .144.

Mixed effect models with individual random effect show significant effect of the of the learning condition on rate of improvement from pre-switch to post-switch block (See table XXX ).

| Predictor                              | Significance for distance improvement | Significance for error improvement |
|:---------------------------------------|:--------------------------------------|:-----------------------------------|
| Intercept                              | p = 0.4                               | p &lt; .001                        |
| Block number                           | p &lt; .001                           | p &lt; .0.05                       |
| Learning condition                     | p = 0.08                              | p &lt; .001                        |
| Block - Learning condition interaction | p = 0.05                              | p &lt; .001                        |

Running separate pairwise t-tests to see individual performance change from pre-switch to post-switch block, we see significant improvement in errors made across all conditions, and marginally significant worsening in distance performance in the desktop condition.

| Learning condition | Distance improvement                                                             | Errors improvement                                                           |
|:-------------------|:---------------------------------------------------------------------------------|:-----------------------------------------------------------------------------|
| Real               | *M*<sub>*d*</sub> = −0.02, 95% CI \[ − 0.26, 0.23\], *t*(21)= − 0.16, *p* = .876 | *M*<sub>*d*</sub> = 0.64, 95% CI \[0.12, 1.17\], *t*(21)=2.56, *p* = .018    |
| Desktop            | *M*<sub>*d*</sub> = −1.13, 95% CI \[ − 2.29, 0.02\], *t*(18)= − 2.06, *p* = .054 | *M*<sub>*d*</sub> = 1.35, 95% CI \[0.19, 2.52\], *t*(18)=2.44, *p* = .025    |
| Treadmill VR       | *M*<sub>*d*</sub> = −0.03, 95% CI \[ − 0.59, 0.53\], *t*(19)= − 0.11, *p* = .910 | *M*<sub>*d*</sub> = 3.34, 95% CI \[2.17, 4.51\], *t*(19)=5.97, *p* &lt; .001 |

We can see that all participants improved in the errors made, but neigher group is significantly worse in the post-switch block in the path travelled (although participants who learned on the desktop performed slightly worse, the significance is only marginal).

### Performance change

To assess the level of performance change form directly before and after the switch, we calculated a personal improvement score as (block3-block4)/(block3+block4)´. This allowed us to directly comapre the percentual improvement or deterioration from pre-switch block to the post-switch one.

![](paper-results_files/figure-markdown_github/unnamed-chunk-7-1.png)![](paper-results_files/figure-markdown_github/unnamed-chunk-7-2.png)

Comparing the perfomance change in different conditions using ANOVA, we see marginally significant difference between groups in the distance improvement (*F*(2, 58)=2.77, *M**S**E* = 0.06, *p* = .071), but significant differences in error rate improvement (*F*(2, 49)=6.72, *M**S**E* = 0.13, *p* = .003). This is consistent with the mixed model result which poited at interaction between block and learning condition.

Tukey post-hoc tests show significant difference between error rate improvement between the group that learned in the real world and that which learned on the desktop.

|                      |        diff| p-value     |
|----------------------|-----------:|:------------|
| Real-Desktop         |   0.4710119| p &lt; .001 |
| Treadmill VR-Desktop |   0.2298740| p = 0.12    |
| Treadmill VR-Real    |  -0.2411379| p = 0.15    |

### Improvement from the pre-switch block to the final block

Looking at participants performance in the pre-switch block and the last block, we can deduce what margin of improvement is possible. We see that participants learning in the real world don't improve significantly more in number or errors *t*(21)=1.26, *p* = .223 but they are continuously imrpoving in distance performance *t*(21)=2.22, *p* = .037.

### Something about pointing?

Summary
-------

We can see different rates of learning speed across different conditions, with significan differences between groups in their performance after the first phase with the real world learning group performing the best, but only significanly different from group learning on the desktop. All conditions show some level of transfer, demonstrated both by general improvement from the first block to the fourth, as well as decreased errors in desktop and treadmill VR group after the switch to the real environment. All groups get to the same level of performance after the three blocks post switch in the real world, not differing in errors made nor distance. But we also observed that whilst real world training leads to almost perfect performance in the 3rd block, not differing from the last block in error rate and only slightly in distance, it takes another three blocks of learning in the real world for the groups which learned on the treadmill or the desktop to achieve same performance.

*I am unsure if it is worth adding the rest of the dataset in (the VR - VR and real - VR groups), but the performance of Treadmill VR groups in the distance traveled gets exactly to the same level as the real world performance in the 6th block (so the VR - VR group performs the same after the 6 blocks as VR - real and real - VR). Which is nice comparison to the results we get here about the distance performance in the real world being almost perfect in the 3rd block and the rest of the groups slowly "getting there".*

*The VR groups still demonstrate larger error difference in the 4-6th block, making more errors overall than the real world groups (about 2 errors per trial more). I believe it can be explained by either social difference - participants not wanting to "ask as much" in the real world, or accidental walking into a door due to treadmill control issues. Also, particiapnts told me that the VR is more "inviting" to test all the doors that are being passed (just in case), because it is more tiring to get back to one in case of a mistake. Anyway, not sure it it warranties adding more groups to the study, but at least the data are consistent and distance performance gets to the same level even in the VR*

We found difference
