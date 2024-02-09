%{
  title: "Scales of Feedback in Software Development",
  author: "Matt",
  tags: ~w(software-development),
  description: "A look at the different scales of feedback cycles in software development."
}
---

One of the best things about software is that you can actually get a concrete answer to the question "Is what I'm doing actually working?"
Until you don't.

Feedback is how we learn, improve, and zero in on solutions.
Without it, we can't get very far.

Feedback happens at a few different scales, some quick and clear, others not so much.
But the name of the game at all levels is to try to tighten that feedback cycle.

## Immediate Feedback - The "Did it work?" Cycle

The tightest cycle is just when you are working on some code.
You write some code, you run it, and you see if it worked or not.
This is what can make programming addictive, and this is what being in the flow state can feel like.

Getting this feedback loop as tight as possible is critical.
Programming went from handing over punch cards (and finding out about the result the next morning) to LSPs which can tell you that you have an issue before you've even ran the code.

One of the most obvious differences that makes a seasoned pro stand out is how much and how often they are getting feedback.
An amateur will end up with entire swaths of a program written without having run or tested any of it.
Compare that to how a veteran works, just slowly but steadily chipping away, consistently getting confirmation about their assumptions so far.
When something doesn't work as expected, the delta between that run and the last run will be small enough that they have a fighting chance in finding the problem.

Short feedback loops are just one reason why Test Driven Development can be such a game changer.
Proper TDD will allow you to work in small increments and get feedback about them right away.

Shorter feedback loops are also one of the reasons people get so fanatical about strong type guarantees from a language.
When your compiler can tell you that something won't work *before* it's even done compiling, it's hard to beat that.

Funnily enough, this can also be a reason people dislike strongly typed languages that won't even let them run this code.
You might think, "Yes, obviously this isn't finished or correct, but let me see if this does what I think it does so far!"

> "I’m feeling defensive again about taking such teeny-tiny steps. Am I recommending
that you actually work this way? No. I’m recommending that you be able to
work this way. What I actually did just now was I worked in larger steps and made
a stupid mistake half way through. I unwound a minute’s worth of changes, shifted
to a lower gear, and did it over with little steps." - Kent Beck, Test Driven Development By Example

The tighter your feedback cycle, the less time you will spend going down dead ends, and the more confidence you'll have about any one change.

## Project Level Feedback - The "Did it work out?" Cycle

The next scale is in terms of the life of a project.

You've got some code that you wrote, hopefully doing so in a way that gave you feedback quickly.
Now you or other developers are continuing to work in the codebase.
Maybe they're integrating your code with existing work, or maybe they're building on top of it.
Maybe, they've found that a portion of your code should be extracted elsewhere so it can be more widely used in your system.

This cycle is where you find out how well your decisions allow this. Or don't. You made some choices. Did it work out?

How long this loop takes can vary by an insane amount.
Consider Alice and Bob, working on two different projects.

Alice is working on a project that has a lot of friction and bureaucracy.
Long delays between finishing work and code reviews, low quality code reviews, then days or weeks before QA approval.
Once her work is finally deemed ready, there's still red tape involved before this code ever gets merged.
Let's be generous and say that it was only a matter of weeks before her changes were integrated into the codebase.
If we're lucky, she and others are starting to work on and around this new code and Alice is finally getting an answer to the question "did it work out?"

Bob, on the other hand, is working on a project that has a lot less friction.
He works on a small team that communicates well together.
Hell, maybe they even work in the same physical location.
They pair program frequently and emphasize making small changes so that code reviews can happen quickly and easily.
They use stacked diffs or do trunk based development so usually, changes are merged in the same day they're completed.
Less than a business day later, Bob and his teammates are working on and with his code.
He's already getting some feedback to how well his choices panned out.

Before anyone even looked at Alice's PR, Bob was already getting feedback.
Now extrapolate this over the course of a year or two.
Which of our two programmers do you think is going to have learned more lessons, and better integrated those lessons into the choices they make next time around?
Obviously Bob, no contest.
Poor Alice is stuck with the project-scale equivalent of punch cards.

What's worse, on a project like that, you might not even be the one to later directly work with the changes you've made.
You might not *ever* get that first-hand feedback.

This is one reason why solo personal projects can be so crucial.
When it's just you, there's no friction or overhead to landing your changes.
You might start building on top of this code right away, giving you immediate feedback about the decisions you made.
And you know that if anyone is going to be working in this part of the codebase, it's going to be you.
On a project like this, you won't have to worry about not getting the feedback.
You'll actually have a hard time avoiding it.

## Product Level Feedback - The "Did It Work Out How You Thought?" Cycle

Now, even if your dev cycle is humming along, that doesn't mean you're through the next big feedback loop: seeing what happens when real users get involved.

I'm not talking the normal question of "Did you build the right thing?"
We are simply trying to learn how wise our technical decisions turned out to be now that it's really being used.

First and foremost, does what you built even work?
Are you getting bug reports or support requests?
Is the performance acceptable?
Are you finding out that, due to design choices you made, it's impossible to surface anything other than a generic all-purpose error message?
That you aren't actually logging any useful information?
Are you getting rate limited by a vital third-party source, jacking up the AWS bill, or just plain blowing up your database?
What other unforeseen consequences are you discovering?

This applies to not only to choices made implementing a single fix, or feature, but also the entire project.
Did you choose the wrong language?
Are you locked in to a framework that isn't cutting it?
Or did you misallocate one of your few innovation tokens?

Of course, getting the feedback at this level is the trickiest of all three.

First of all, this cycle is going to be a longer loop that your project development cycle.
Getting your code merged might be one hurdle, but actually getting it in front of users might happen at an entirely different time frame.
Even if changes land and get deployed quickly, it might be a month until it's ready for real use.
Product managers might be perfectionists, or maybe your code sits and waits behind a feature flag while waiting for the date that a Marketing team decided.
Or even if the changes are live quickly, users aren't rushing to try it out or install the new version of your app.

What's worse, it's very possible that you never get this feedback.
This can be based on things that are totally out of your control, like how your org handles error tracking, logging, metrics, billing, and support.

## Conclusion

Did it work? Did it work out well for you? And did it work out how you thought?
At each level, you always want to get the feedback and tighten the loop.
