* run: webdoc do VELOCITYanalysisVersion01markdown.do
set more off
* figure numbering
local gr 1

* prepare markdown
capture drop VELOCITYanalysisVersion01markdown
webdoc init VELOCITYanalysisVersion01markdown, replace header(stscheme(classic))
/***
        <!DOCTYPE html>
        <html><body>
		<font size="+2"><b>VELOCITY project</b></font>
        <p>Analysis of the VELOCITY data, comparing growth and glucose CGMS.</p><hr>
        <strong>Table of contents</strong> 
***/
webdoc toc, numbered

* start document
/***
		<hr>
		There are 3 datasets<br>
		1. CGMS master 020821.dta<br>
		2. GMS master with metrics 020821.dta<br>
		3. VELOCITY merged master.dta<br>
***/

/*** 
        <h1>Data sets</h1>
***/

/*** 
        <h2>CGMS master 020821.dta</h2>
***/
use "C:\Users\Graham\OneDrive - University of Lincoln\research\diabetes\velocity\data\CGMS master 020821.dta", clear
d

/***
<p>Number of observations
***/
webdoc stlog once: count

/***
<p>Categorisation of birth weight
***/ 
webdoc stlog once: tab compscore, m
/***
<p>Measure of growth
***/ 
webdoc stlog once: tab growth, m
/***
<p>Days gestation for glucose measurement
***/ 
webdoc stlog once: sum GestVisit
/***
<p>Weeks gestation for glucose measurement
***/ 
webdoc stlog once: sum weeksGestation
/***
<p>How many mothers?
***/ 
webdoc stlog once:  unique IDnumber
* 202 mothers

/*** 
        <h2>GMS master with metrics 020821.dta</h2>
***/
use "C:\Users\Graham\OneDrive - University of Lincoln\research\diabetes\velocity\data\CGMS master with metrics 020821.dta", clear
d

/***
<p>Number of observations
***/
webdoc stlog once: count

/***
<p>Measure of birth weight
***/
webdoc stlog once: tab compscore, m

/***
<p>Measure of growth
***/
webdoc stlog once: tab growth, m

/***
<p>Days gestation for glucose measurement
***/
webdoc stlog once: sum GestVisit

/***
<p>Weeks gestation for glucose measurement
***/
webdoc stlog once: sum weeksGestation

/***
<p>How many mothers?
***/
webdoc stlog once: unique IDnumber
* there are 202 unique IDs

/*** 
        <h2>VELOCITY merged master.dta</h2>
***/
use "C:\Users\Graham\OneDrive - University of Lincoln\research\diabetes\velocity\data\VELOCITY merged master.dta", clear

* Based on fetal growth plus pregnancy outcome
* Normal – normal growth with normal outcome
* Macrosomia – accelerative growth with poor pregnancy outcome
* FGR – decelerative growth with poor pregnancy outcome
* LGA – normal or accelerative growth with a normal pregnancy outcome, birthweight centile >90th
label define compscore 0 "normal" 1 "macrosomia" 2 "FGR" 3 "LGA"
label values compscore compscore 
* Based on the change fetal growth alone
label define growth 0 "normal" 1 "decelerative" 2 "accelerative" 
label values growth growth 

/***
<p>Number of Visits
***/
webdoc stlog once: count

/***
<p>How many mothers?
***/
webdoc stlog once:  unique IDnumber

/***
<p>Presentation at birth
***/
webdoc stlog once: tab Presentation, m

/***
<p> Number of visits: classified by growth based on the change in fetal growth alone
***/
webdoc stlog once: tab growth, m

/***
<p> Number of visits: classified by growth based on fetal growth plus pregnancy outcome  <br>
* Normal – normal growth with normal outcome  <br>
* Macrosomia – accelerative growth with poor pregnancy outcome  <br>
* FGR – decelerative growth with poor pregnancy outcome  <br>
* LGA – normal or accelerative growth with a normal pregnancy outcome, birthweight centile >90th  <br>
***/

***/
webdoc stlog once: tab compscore, m

/*** 
        <h2>Data summary</h2>
		<hr>
		There are 3 datasets<br>
		1. CGMS master 020821.dta<br>
		n==2,095,730<br>
		This is the total data, with CGMS matched to growth speed.<br>
		2. GMS master with metrics 020821.dta<br>
		n==2,095,730<br>
		This is the total data, with CGMS matched to growth speed and glucose metrics. <br>
		3. VELOCITY merged master.dta<br>
		n==1,792<br>
		This is the data for each visit for each mother, including the growth data.<hr>

I am using data in (2) GMS master with metrics 020821.dta.

Data has:
(a) Growth data
(b) Date, time
(c) Glucose 
(d) Glucose metrics/variability

***/

/***
		<h1>Baby growth data</h1>
		<br>
		* BPD (biparietal diameter), the diameter of the baby's head  <br>
		* HC (head circumference), the length going around the baby's head  <br>
		* AC (abdominal circumference), the length going around the baby's belly  <br>
		* FL (femur length), the length of a bone in the baby's leg  <br>
		using [VELOCITY merged master.dta]<br>
***/

use "C:\Users\Graham\OneDrive - University of Lincoln\research\diabetes\velocity\data\VELOCITY merged master.dta", clear
label define compscore 0 "normal" 1 "macrosomia" 2 "FGR" 3 "LGA"
label values compscore compscore 
label define growth 0 "normal" 1 "decelerative" 2 "accelerative" 
label values growth growth 

/***
		<h2>Plot baby growth data at each visit</h2>
		<br>
***/

* BPD
twoway (scatter BPD GestDays1) (lpolyci BPD GestDays1), ytitle(Biparietal diameter (BPD)) xtitle(Days gestation) legend(off) xlabel(minmax)
webdoc graph, figure(gr-`gr') caption(Figure `gr': Biparetal diameter (BPD) by days gestation) cabove
local gr = `gr'+1

* HC
twoway (scatter HC GestDays1) (lpolyci HC GestDays1), ytitle(Head circumeference (HC)) xtitle(Days gestation) legend(off) xlabel(minmax)
webdoc graph, figure(gr-`gr') caption(Figure `gr': Head circumference (HC) by days gestation) cabove
local gr = `gr'+1

* AC
twoway (scatter AC GestDays1) (lpolyci AC GestDays1), ytitle(Abdominal circumference (AC)) xtitle(Days gestation) legend(off) xlabel(minmax)
webdoc graph, figure(gr-`gr') caption(Figure `gr': Abdominal circumference (AC) by days gestation) cabove
local gr = `gr'+1

* FL
twoway (scatter FL GestDays1) (lpolyci FL GestDays1), ytitle(Femur length (FL)) xtitle(Days gestation) legend(off) xlabel(minmax)
webdoc graph, figure(gr-`gr') caption(Figure `gr': Femur length (FL) by days gestation) cabove
local gr = `gr'+1

/***
Femur length (FL) has a series of very low measures - following plot is removing FL < 10 
***/
* FL - only above 10
twoway (scatter FL GestDays1) (lpolyci FL GestDays1) if FL>=10, ytitle(Femur length (FL)) xtitle(Days gestation) legend(off) xlabel(minmax)
webdoc graph, figure(gr-`gr') caption(Figure `gr': Femur length (FL) by days gestation) cabove
local gr = `gr'+1

/***
<br>
Estimated foetal weigh per visit, at the time of the scan
***/
* Estimated foetal weight (g)
twoway (scatter Estimatedfetalweight GestDays1) (lpolyci Estimatedfetalweight GestDays1), ytitle(Estimated foetal weigtht) xtitle(Days gestation) legend(off) xlabel(minmax)
webdoc graph, figure(gr-`gr') caption(Figure `gr': Estimated foetal weight (g) by days gestation) cabove
local gr = `gr'+1

/***
		<h2>Examine each mother/baby individually</h2>
		<br>
***/


 

 




