%{
  title: "The Economic Arguments For Code Quality",
  author: "Matt",
  tags: ~w(software-development AI LLM),
  description: "Even if everything is working fine today, low quality code can impact your bottom line."
}
---

It's late 2026 and there has been mass adoption of AI coding tools in the software industry.
A lot of people are wondering if the quality of the code matters at all anymore.
After all, poorly written code that an LLM works on is like a tree falling in the woods with no one to hear it.

If the wheels are turning and the business is working, why should anyone care?
Where does quality matter and where can we ignore it?

My argument is that even if everything is working fine today, low quality code can impact your bottom line.

## What Do We Even Mean By Code Quality?

Entire books have been written about this, but my definition of quality comes down to this:

> High quality code is easy to understand, use, test, and most importantly, *change*.

Imagine two codebases that do the exact same thing.
They have have the same set of features, the same performance, and are equally reliable and secure.

One is written in a high-level language, with comments and documentation, and is designed in a way so that it's easy to test.
The other is just the equivalent assembly code.

It's time to add a new feature, alter some functionality, or tweak the architecture to support a new level of scale.
Which is going to be easier to change?

## Easy is Inexpensive

"Who cares if it's easy?", you might say.
"Make the AI do it!"

Easy to change means the work can be done sooner, no matter who does it.
If the design is any good, it means the surface area of changes will be smaller, and so verifying these changes will require less of an investment.

Even if you want to throw AI at the problem, you still have the problem of making sure the result is what you wanted in the first place.

If the existing code is easy to use, there will be that much less new code that needs to be added.
If it's easy to test, it will be cheaper to iterate on and you will have more confidence in the results.

Quality code will have less Butterfly Effect, so you can confidently change one part of the system without too much fear that some completely unrelated area is suddenly going to behave differently.
Think about our two codebases above, which is going to be riskier to change?

## Agile is About Deferring Costs

At the end of the day, Agile software development is all about deferring as much cost as possible while steadily delivering value.
Instead of developing an entire product before releasing the first version, you only invest in building the next slice, and then you ship it.

How do you ensure that you can keep doing this at a steady pace?
Well, one of the Principles behind the Agile Manifesto[^1] is:

> Continuous attention to technical excellence
and good design enhances agility.

If your code is high quality (and therefore easy to change), this ability to quickly adapt is a competitive advantage for your business or customer.

[^1]: [Principles behind the Agile Manifesto](https://agilemanifesto.org/principles.html)

## Options

In Tidy First?[^2], Kent Beck describes the economic value of a software system as the things it can do today plus the things it could do tomorrow.
Each of those things it *could* do is an option[^3] to be exercised or not.

[^2]: [Tidy First?](https://www.oreilly.com/library/view/tidy-first/9798341643932/)
[^3]: [Option (finance)](https://en.wikipedia.org/wiki/Option_(finance))

If your code is hard to use (or reuse), you just have less options.
If you don't understand the code, you have no idea of knowing how expensive (or not) each of those possibilities are.
You might not even be aware of many of the options in your portfolio.

If you can't easily change your code, it's going to be more expensive to exercise those options.

## The Sweet Spot

As your system gets more features and complexity, the costs of future development and maintenance goes up.
As the quality of the code improves, these get easier and cheaper.

You can't only invest in features and fixes.
Eventually, pace of development grinds to a halt, every change has some unintended consequences, and the project enters a downward spiral.

But you also can't only invest in improving the quality of the code, because on its own, this doesn't create any value.
This is like spending all your time sharpening the axe but never actually chopping down the tree.

The name of the game is to find the sweet spot where you are generating enough value today while keeping options open and keeping the development process running smoothly.
Depending on the kind of project, what phase the project (or company) is in, and the business model itself, this sweet spot can be in a different place.

## Not All Investments Are Equal

Some investments are tiny and pay for themselves immediately.

For example, in Test Driven Development, you invest in writing tests first, with the expectation that the time spent writing (and running) the tests will pay off.
If you spend an extra minute up front writing a test, and this test saves you the same amount of time over the course of implementing some behavior, then you broke even.

What if it prevents you from spending even five minutes going down a dead end?
Now the investment has paid for itself even if you never commit the tests.

How about if it prevents you from shipping a bug in the future?
Now the ROI (Return on Investment) is all of the time it would have taken to process the bug report, assign the work, make the fix, review it, validate it, deploy and monitor it.
That's not even taking into account any data that might need to be corrected, damage to your reputation (both you and your product's), and so on.

But what if the test is long and complicated to write, slow to run, the results are unreliable, and only covers a narrow sliver of what could be tested?
This investment might never pay for itself.

In Software Design X-Rays[^4], Adam Tornhill lays out some approaches for finding areas for paying off tech debt where you will have the most ROI.

[^4]: [Software Design X-Rays](https://pragprog.com/titles/atevol/software-design-x-rays/)

His general thesis is that you can't improve everything, so focus on the areas that matter.
If you pay off tech debt in code that is changing often, causing issues, or is worked on by a lot of different people, you'll get a return on that investment.
Other areas might be poorly written, impossible to understand, or have a bus factor of zero, but if they're not actively causing problems and no one is changing it, improving it won't have any payoff (until, of course, someone does need to change it).

## Software Quality Crisis

We are in a software quality crisis, and have been here for years.
I don't know if it's getting worse or not, but it's certainly not getting any better.

Look around, most anything you use has serious bugs.
If you need to be convinced of this, try Jonathan Blow's experiment[^5] where he decided:

>  "I'm just gonna take a screenshot every time any piece of software that I use has an obvious bug or unintuitive or incorrect piece of behavior."

[^5]: [Preventing the Collapse of Civilization](https://youtu.be/ZSRHeXYDLko?t=1380)

It's so frequent, that we have gone numb to it in our day to day experience.
He argues that we don't even expect software to work correctly anymore.
Even major companies, whose only business is software, no longer seem capable of delivering software that works reliably.

Even if things are working perfectly today, software is almost never done.
After all, maintenance is often the majority of the total cost of software.
Change is always coming, and low quality code makes this change more expensive.
It's harder to fix one thing without breaking others, it's harder to adapt and evolve, and it takes longer to handle the next level of scale.

If your customers can't count on you to fix existing problems without creating new ones, they're not going to be patient forever.
They'll stop reporting bugs and simply take their business somewhere else.
If you can't respond to their needs in a timely manner, they're going to to churn.
If you can't react to increasing demands quickly, those demands might not still be there by the time you're ready for them.

Even in a startup, low code quality can ruin your ability to pivot while trying to find Product-Market Fit.

And even in a business where software is not the product itself, like a bank, it's still part of the service.
Poor code quality can make the service more expensive to operate than it needs to be.
This can show up as needing more developers, moving slowly, or just having worse results.

And every time time you change it, it can introduce any number of issues that *will* cause customers to leave.
I'm not going to pick my bank based on their web app, but if the customer service is slow, the app has frequent downtime, my balance isn't accurate, the fraud detection is broken or my data gets leaked, then I'm going to switch banks for sure.

## Quality as Competitive Advantage

The flip side is that quality can be a competitive advantage.

If you can understand your code, you can know what's possible.
You know what's easy and can be shipped in two weeks versus what sounds simple but will take six months.

If you can fix one bug without introducing others, you can ship something that your customers can rely on.
If changes to your system can be quick, inexpensive, and reliable, you can adapt to changing business landscapes and respond to customer needs.

At a time where your competitors can't do these things, being able to do these things could make all the difference.
