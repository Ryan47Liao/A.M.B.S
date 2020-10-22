# Arbitrary Martingale Betting System
![MBS Intro](https://www.5paisa.com/school/Includes/Image/averaging/3Martingale%20betting%20system.jpg)

## Summary
Arbitrary Martingale Betting System is an algorithm that transforms betting options from discrete fixed rules into almost continuous ranges that fully tailers your own needs. In a short word, it allows you to make the Rules yourself. With AMBS, Cascino can become your second place for investment. In this ReadMe, I will walk you through the history of Martingale, my inspirations, the adaptations applied, and applications along with mathematical proofs and other discussions.

## History of Martingale Betting System
A martingale is any of a class of betting strategies that originated from and were popular in 18th-century France. The simplest of these strategies was designed for a game in which the gambler wins the stake if a coin comes up heads and loses it if the coin comes up tails. The strategy had the gambler double the bet after every loss so that the first win would recover all previous losses plus win a profit equal to the original stake. The martingale strategy has been applied to roulette as well, as the probability of hitting either red or black is close to 50%.  

Since a gambler with infinite wealth will, almost surely, eventually flip heads, the martingale betting strategy was seen as a sure thing by those who advocated it. None of the gamblers possessed infinite wealth, and the exponential growth of the bets would eventually bankrupt "unlucky" gamblers who chose to use the martingale. The gambler usually wins a small net reward, thus appearing to have a sound strategy. However, the gambler's expected value does indeed remain zero (or less than zero) because the small probability that the gambler will suffer a catastrophic loss exactly balances with the expected gain. In a casino, the expected value is negative, due to the house's edge. The likelihood of catastrophic loss may not even be very small. The bet size rises exponentially. This, combined with the fact that strings of consecutive losses actually occur more often than common intuition suggests, can bankrupt a gambler quickly. (From Wikipedia)

#### Comments:
Traditional MBS, is indeed, as simple as above. The description above captures the two significant features of MBS:
1. Its Ideology "Double your bet every time you lose" is indeed a good way to put it, but it's far from accurate. In the case where the odd is 1:1, coin flips, for instance, your action is true: Double your next bet. Since then if you win, you will win all your 'sink costs' back plus your initial bet. This Ideology is essential of MBS and actually extends to all scenarios which I will discuss in the following paragraphs: Bet an amount such that, if you win, you would win all your 'sink costs' back plus you're the amount of reward if you win the first time.
2. Infinite Wealth Traditional MBS is often believed to be unpractical due to the shared belief that "One needs to have infinite wealth to guarantee that MBS will eventually work". This belief, I assume comes from the experiences of the players from the 18th century who have little to none grasp of probability theory. Although the Wikipedia description about how the "Bet" grows exponentially and it's possible that someone is very unlucky and keeps losing straight up are Both True, infinite wealth is NOT Necessary. In the traditional approach, MBS is like the following: WHILE you have not won for once, keep adding your bet so that "if you win, you would win all your 'sink costs' back plus you're the amount of reward if you win the first time." However, an adaptation can be made: observing the stake (amount of investment) you wish to spend, and divide the stake in a way it supports n consecutive failures. I will explain this in full detail in the upcoming sections.

![Inspiration](https://miro.medium.com/max/1200/1*K0w6c8Mv7V80iwgWjSK0Zg.jpeg)
## Inspiration
I remember it was the first year as a Math major and I took my first programming course (Matlab was the first program language I learned). It so happened that I was taking a Math class about Finance, Arbitrage and stuff plus a intro-level of statistics. Back then, I did NOT know anything about MBS, do not know that it exists, but an interesting (at least for me) thought experiment captured my attention for almost an entire afternoon:"If you roll a dice, there is a 1/6 chance that you will get '1', then how many times you need to roll to "guarantee" that you get at least one '1'?" Before I take the stats course, I would probability answer 6, as it appears to be the only number in the question and it sort of 'make sense'. That, is completely errors, however. In fact, to be 99% certain that you will get at least one 6, you will need to roll 25.259 times!!! Since I have derived the formula for **n** as the number of times to roll, to archive **cp**(cumulative probability) at **p**: n(p,cp) = <img src="https://render.githubusercontent.com/render/math?math=\frac{ln(1-cp)}{ln(1-p)}"> (For proof details see *Appendix_A_1*). 

Now with this powerful tool (formula) added to our toolbox, we have acquired the key towards a **Finite** Wealth based MBS system. Just name the probability you want to achieve, and this formula will output the number of times you need to play to achieve such probability. Here is how this works: Assume there is this game where if you flip a coin and get 'head', the odd is 1:1, such that whatever the amount you pay, you get it to bet back. Now, assume you want at least 96% of confidence that you win at least once, how many time do you need to bet? Just plug in CP = 0.96 and P = 0.5 into our formula, and whola! You get n = 4.64, so you need to bet at least 5 times to have a **96%** cumulative probability (or confidence) that you can win at least once. And this setting, sounds so familiar right? In the premise of MBS, as long as you can win once before you broke, **you WIN all your sink costs PLUS your first Reward!** So now, say you want to win $10, how much do you need to prepare to play 5 times? You would need $310 to do that. (I have worked out the formula for you: **Money_need = Bet * (2^n - 1)**, check Appendix_A_2 for proof details.)

Next, let's change the way the Question is Asked: If you have $310, and you want to be 96% CONFIDENT, how much should you bet in the first bet? Now you know it's $10 from the previous example. But what if you want to be only 80% confident, what then???

Simple! Let's check our tool box: **Money_need = Bet * (2^n - 1) , n = ln(1-cp)/ln(1-p)" **now if we 'do a little algebra' Bet with Money_need (Since it's fixed now), we will have the formula that gives our first Bet: **Bet = Money_needed / (2^(ln(1-cp)/ln(1-p)) - 1)** And if we plug in all the coefs, we get: Bet = $62! Then you know what to do next, simple: double your last bet untill the 5 times (ln(1-0.8)/ln(1-0.5)) time.

So that's it! You do not need to be infinitely wealthy to take advantage of the MBS scheme! Just need to do some math and forge a plan! But now comes the question...Can you extend to an arbitrary scenario where the payoff is Not 1:1? Certainly, and that's why it's called ARBITRARY Martingale Betting System since whatever the rules, just plug in the numbers and the Formula Looks like this:
![AMBS Formula](https://www.linkpicture.com/q/QQ图片20201021212637.png)
Which is Almost Identical to what we've got now! And the Proof is absolutely Neat. If you wish to see the entire derivation of this essential formula, please do not hesitate to go Directly to 【Appendix_A】. I will meet you there!
  
## Application
1. **Black Jack** is automatically the place to start! With 1:1 pay off rates, you can apply the traditional Martingale Betting System even without the help of an algorithm! Although this game does require a certain degree of technique, you can simply assume that the Probability to win: 42.22% and derive your betting Sequence based on your bankrolls.
![Black Jack](https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1051931270%2F0x0.jpg%3Ffit%3Dscale)
2. **Roulette** is my favorite game of which I can apply A.M.B.S over. It's the PERFECT Game for AMBS: Its payoffs ranging from simple 2 to 35, combined with AMBS, offers an almost continuous plan where you can choose from. This game has no operation and so you can only focus on your schemes. Dividing your bankroll however you like to achieve the ideal outcome with CONFIDENCE!
![RLT](https://www.liveabout.com/thmb/IgNSqSq25vXZJHs7WeJv4FyAeBc=/1500x1000/filters:fill(auto,1)/RouletteTable-58c2bb9a5f9b58af5c9ea220.jpg)
3. **And More**... There are so many games in the CASINO that supports AMBS. As long the game meets the following criteria:
- [x] Given Wining Rates (Or Estimatble ones like Black Jack)
- [x] You have control over your Bets (Although some have ceiling and floors, the program takes care of that for you!)
- [x] The Pay Off is Constant, or at least estimate (Not like Texas hold 'em that the pay off is completely undetermined)

You are good to Go! That been said, the application of A.M.B.S actually extends outside of the Casino. Since Stock Markets alike to fulfill the above descriptions in away. Personally, however, I have not looked into this field and I encourage you to explore its potential possibilities!
![Stock_Market](https://api.time.com/wp-content/uploads/2020/03/stock-market-coronavirus-2.jpg)

## Program Tutorial  
https://www.youtube.com/watch?v=8lXoNoNbVKI&t=16s

## Advantages
- [x] **Profitable**: If you have enough bankroll, AMBS is actually superior to some Financial Bundles. Consider this, some Financial Bundles offer you a 20%-30% return over about a year and still have a volatile chance of losing all your investment. AMBS empowers you to get returns ranging from 1% to 100% instantly, and the risk, just like the pay off is completely manageable.
- [x] **Simplicity**: You do not need to watch reports, study a company, practice skills, etc. Just put in the variable and follow the "Bet Sequence" to bet your every bet, it's as simple as that!

## Disadvantages
- [ ] **Negative Expected Value**: To be honest with you, you can not rely on your income on AMBS and quit your jobs. No matter how advanced this program is (Not to mention it's really simple), it would never change the fact that all games in the Cascino are designed so that it has a negative expected value. In other words, you might win money from time to time, but if you keep playing, the amount you lose in long run eventually outweighs your income.
- [ ] **Protability**: This is improvable, but I doubt if the Cascino would just let you walk in with your computer and calculate the odds :D Good luck with that! (Online Casinos are Safer)

## 【Appendix_A】 Mathematical Proofs
1. https://drive.google.com/file/d/11LMRiHsOEeMKJIc7Xyqetqv7x536ML2D/view?usp=sharing
2. https://drive.google.com/file/d/11LMRiHsOEeMKJIc7Xyqetqv7x536ML2D/view?usp=sharing
3. Final Proof for the Series:https://drive.google.com/file/d/1YenFiljygGDkQOfC4_ezPG9PQZeVadkd/view?usp=sharing
## 【Appendix_B】 Extra Discussion 
1. **Arbitraging w/ a Random Guy**TBA
2. **Altering the Utility Function**
3. **Applications in the Financial World**TBA
