# __TurnOver (TO)__

> __Each TO has three periods :&emsp;__ __<font color="blue" size=3>*identification —> stable —> transition*</font>__
>
>|       identification       |      stable      |                       transition                       |
>| :------------------------: | :--------------: | :----------------------------------------------------: |
>| TO = -1 &&ensp; stable quote = 1 | stable quote = 1 | last stable quotes = -1 &ensp;& TO = -1&ensp;( stable quote = 1 ) |

## basic conceptions  
>
>+ __bid__ : A limited order to <font color="blue" size=3>open a short position</font> or <font color="blue" size=3>close a long position</font>, the sell order placement with __limited Price,Volume and Time horizon__.  
>
>+ __ask__ : A limited order to <font color="blue" size=3>open a long position</font> or <font color="blue" size=3>close a short position</font>, the buy order placement with __limited Price,Volume and Time horizon__.  
>
>+ __spread__ : The difference of bid-ask
>
>```java
> spread: lowest bid - highest ask
>```
>
>+ __5 level quatations__ : Show the __top__ 5 ask quotes and __bottom__ 5 bid quotes.
>
>+ __Order Book__ : Historical information list of all the historical __snapshots__ which include __bid ask spread and transaction information__ that happen in a fixed time interval.  
>
## parameters  
>
> ```java
> bid_price = bp;    //bid price of current snapshot.
>
> ask_price = ap;    //ask price of current snapshot.
>
> end_bid_price = ebp;    //bid price at the end of the transition period in this TurnOver. (Actually it’s the bid price of the previous snapshot.)
>
> end_ask_price = eap;   //ask price at the end of the transition period in this TurnOver. (Actually it’s the ask price of the previous snapshot.)
>
> start_bid_price = sbp;    //bid price at the beginning of the stable period in this TurnOver.
>
> start_ask_price = sap;   //ask price at the beginning of the stable period in this TurnOver.
>
>c1 = 0.05;    // Deviation 
>
>c2 = 0.25;    // Deviation 
>
>TransitionPeriod_end_mid_price = (end_bid_price + end_ask_price) / 2;
>
>CurrentSnapshot_mid_price = (bid_price + ask_price) / 2;
>```

## __Case 1 : Identified > Have transition period__
  
### __a. Price continues moving__

  > #### Rules
  >
  > ##### &ensp;First, satisfy any one of the following
  >
  >```java
  >1. CurrentSnapshot_mid_price - TransitionPeriod_end_mid_price >= c1;
  >2. (bid_price - end_bid_price) + (ask_price - end_ask_price) >= c2;
  >```
  >
  > ##### &ensp;Next, satisfy any one of the following
  >
  >```java
  >1. CurrentSnapshot_mid_price - StablePeriod_start_mid_price >= c1;
  >2. (bid_price - start_bid_price) + (ask_price - start_ask_price) >= c2;
  >```
  >
  > ##### &ensp;Operations
  >
  >```java
  >1. Add current snapshot to transition period ;
  >2. Return 1;    // It means that it’s in stable period.
  >```
>
> #### <font color="sky blue">&ensp;Image example : Price continues moving</font>
>
> ![image example](/194254.png "Price continues moving")  
  
### __b. Price moves back__

  > #### Rules
  >
  > ##### &ensp;First, satisfy any one of the following
  >
  >```java
  >1. CurrentSnapshot_mid_price - TransitionPeriod_end_mid_price >= c1;
  >2. (bid_price - end_bid_price) + (ask_price - end_ask_price) >= c2;
  >```
  >
  > ##### &ensp;Next, satisfy any one of the following
  >
  >```java
  >1. CurrentSnapshot_mid_price - StablePeriod_start_mid_price <= c1;
  >2. (bid_price - start_bid_price) + (ask_price - start_ask_price) <= c2;
  >```
  >
  > ##### &ensp;Operations
  >
  >```java
  >1. Add transition period to stable period;
  >2. Clear transition period;
  >3. Return 0;    // It means that it’s in transition period.
  >```
>
> #### <font color="sky blue">&ensp;Image example : Price moves back</font>
>
> ![image example](/205003.png "Price moves back")

### __c. Price stabilize__

  > #### Rules
  >
  > ##### &ensp;Satisfy any one of the following
  >
  >```java
  >1. CurrentSnapshot_mid_price – TransitionPeriod_end_mid_price <= c1;
  >2. (bid_price - end_bid_price) + (ask_price - end_ask_price) <= c2;
  >```
  >
  > ##### &ensp;Operations
  >
  >```java
  > 1. Add current snapshot to transition period;
  > 2. New identification period;    // It means new TurnOver.
  > 3. Return -1;    // It means that we need to create a new TurnOver.
  >```
>
> #### <font color="sky blue">&ensp;Image example : Price stabilize</font>
>
> ![image example](/212338.png "Price stabilize")

## __Case 2: Identified > Have no transition period__
  
### __a. Price moves away__

  > #### Rules
  >
  > ##### &ensp;Satisfy any one of the following
  >
  >```java
  >1. CurrentSnapshot_mid_price - StablePeriod_start_mid_price >= c1;
  >2. (bid_price - start_bid_price) + (ask_price - start_ask_price) >= c2;
  >```
  >
  > ##### &ensp;Operations
  >
  >```java
  > 1. Add current snapshot to stable period;
  > 2. Use current snapshot price to initialize transition period; 
  > 3. Return 1;    // It means that it’s in transition period.
  >```
>
> #### <font color="sky blue">&ensp;Image example : Price stabilize</font>
>
> ![image example](/213758.png "Price moves away")
  
### __b. Price stable__

  > #### Rules
  >
  > ##### &ensp;Satisfy any one of the following
  >
  >```java
  >1. CurrentSnapshot_mid_price - StablePeriod_start_mid_price <= c1;
  >2. (bid_price - start_bid_price) + (ask_price - start_ask_price) <= c2;
  >```
  >
  > ##### &ensp;Operations
  >
  >```java
  > 1. Add current snapshot to stable period ;
  > 2. Return 0    // It means that it’s in stable period.
  >```
>
> #### <font color="sky blue">&ensp;Image example : Price stabilize</font>
>
> ![image example](/214024.png "Price stable")