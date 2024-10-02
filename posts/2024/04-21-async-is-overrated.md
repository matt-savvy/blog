%{
  title: "Hot Take - Async collaboration is Overrated",
  author: "Matt",
  tags: ~w(work),
  description: "One of my unpopular opinions, asynchronous collaboration is not so great"
}
---

One universal truth in programming is a single-threaded, sequential process is always going to be easier to work with than highly concurrent or parallel system.
We all know that as soon as you start dealing with concurrency, you open the door to another level of complexity.
Trying to act as if it doesn't is just going to get you into trouble.
So why do we pretend that we don't have to pay similar costs when trying to make our entire team collaborate asynchronously?

## What is Collaboration?

Collaboration can mean a lot of things to a lot of people, but for what we're talking about here, I'll just give you some examples:
- decision making
- assigning work
- getting more information
- code review
- troubleshooting

For example, if you and I need to decide which approach to take on how to implement some new functionality, that's collaboration.
If I delegate work, have work delegated to me, have questions to be answered, or feedback to give someone else, this is all collaboration too.

## What is asynchronous collaboration?

Let's start with what synchronous collaboration looks like.
The defining feature is that if I ask you a question or tell you something, we are both expecting that you will respond to me.
For example, I ask you a question, you give me a response then and there.
Even if that response is "I don't know", "I don't understand the question", or "I'm not going to tell you that."
If one of us wants to give some feedback or correct a mistake, it's expected that we can do that right away.
We can even interrupt each other if need be!

Async collaboration, on the other hand, is defined by anything where you will get a response sometime in the future, or not at all.
Let's say I send you a message to ask you a question.
I might not ever even know if you got the message, let alone read and comprehended it, and when you plan to get back to me.
Or if you don't plan to get back to me at all!

One important detail is that asynchronous can happen very quickly (on a scale of seconds or minutes), but there's no guarantee.

## The Costs

So what's the problem?
You might be thinking, "Async is great, I don't want to be interrupted all the time!"
Of course you don't!
But this tradeoff is not free.

### More balls in the air

The most obvious problem is that async leads to us all juggling way more different things.

Let's say I start on a piece of work, but I have some questions about the ticket.
I can't get very far until I have those questions answered.
So I fire off a message to the author, and now I wait.

I wait just long enough to convince myself that I'm not going to get an answer back right away, then I either walk away from my computer, hoping that I will have a response by the time I get back, or I find something else to do.
But, I'm a human, and I don't have a perfect process scheduler, and so I pay a real mental tax for switching to whatever this new context is.

In the best case scenario, I have just enough time to finish this new task, and then get back an answer that resolves all of my questions.
But there are going to be way more times where I get a response as I'm partially in to this new task.
And the response doesn't answer all of my questions, and it actually contains questions of its own.
Who knows how many back and forth context switches it will take for us to both resolve our questions?

It's not just one thing to do, but that any of the tasks we start might turn into these completely open threads, forcing us to context switch between any and all of them.
The worst case scenario is that you keep opening new loops faster than they get closed.
For example, let's say every day, three new PRs get opened for you to review, and you have a few questions on two of them.
Day one, you'll be done with one PR, but the other two are still open loops, threads that could demand your attention at any time.
Day two, you have three new ones to review, one of which you can finish outright, and two more that turn into an async process.
After just a few days of this, if the responses aren't resolving the issues, you are juggling too many open loops and paying the price.

### More room for attention hijacking

Sometimes the issue isn't just that I started on some new work, but it's that I got my attention pulled into something else.
Maybe this is something productive, like helping a teammate troubleshoot, joining an ongoing discussion, or just catching up on some messages.
There's still a cost for switching contexts there, unless it's tightly related to what I was just working on.

And, let's be real, most people aren't limited their context switches to just what's going on with their work.
I personally don't use social media, but I know that the vast majority of people are scratching this itch right after they asked their question.
Maybe it's just for a few minutes, or it's something less nefarious like skimming HN, or it's just grabbing their phone and reading their texts.

The end result is that you're not only forced to have these gaps, but you're also literally conditioning yourself to reach for distractions in these moments.
So now you have a workday that is filled with these moments ripe for attention to get hijacked, worked by individuals who have rewired their brains to turn their attention over.

### Delegation isn't free

One work cliche is that you shouldn't try to do everything yourself, that you should be able to delegate work, but few people seem to appreciate that this comes with a cost too.

One of the easiest ways to delegate is to just add a ticket for this work to be done later.
This defers it as well, which can be great.
But this is just a sleeping process, which can still come demanding your attention at any point.
You never know when someone is going to crack that ticket open and end up putting more work back on your plate.
It might be as simple as asking a few questions about the work, getting more clarity on what you wrote.
But it can easily be something you need to code review, validate, troubleshoot, weigh in on decisions to be made, or just plain do this work after all.

Sometimes, it's simpler to just do it yourself in the first place.

### Feedback

I previously wrote about how important feedback is to programmers, and how vital it is to get the fastest feedback loop possible.

For example, we would never accept a regular workflow where you wrote your code, submitted it, and had to wait overnight to find out if the run was successful or not.
However, for some reason, we decide this is totally fine for getting feedback from your team about the code itself.
Twenty-four hours is a totally normal turnaround time for code review.

In a perfect world, the moment I begin going down the wrong path, I would be able to get some feedback that I was off track.
And if someone else is completely blowing past scope, over-engineering, not actually addressing the issue, or otherwise blowing it, they probably want to know that as soon as possible too.

Our asynchronous system of writing code, opening Pull Requests, and then getting questions, comments, or approvals forces us to treat each other as a black box.
You have no insight into how someone is doing the work.
Best case scenario, the work was broken into a nice series of commits that gives you some idea, but it's more likely that it wasn't.
This removes your ability to give and receive feedback about how you work.
And surprise surprise, this feedback is how we get better.

There is a way around all of this, and it's called pair programming.

### Async Messaging is Terrible

The main way we communicate in any modern org is through some form of async written messages, like emails, Slack, comments, and shared documents.
And I might not the first person to point this out, but written messages are usually the worst way to communicate.

The recipient will misunderstand you.
They will misinterpret you, deliberately or otherwise.
They will misread, skim, or skip through your message while (half) doing something else.
They will ignore your message entirely.
They will see your message while in the middle of doing something else, and make a mental note to reply to you later when they have time.
But they are also human and these mental post-it notes won't stick.

And of course, every one of these conversational threads can include any number of participants, and any one of them can derail a conversation, or just turn it into a spiderweb of different ideas and side-conversations.

Maybe some of these issues would be reduced by relying more on voice and video messaging, but it still doesn't solve the biggest issues.
You still don't know if someone really got your message, if they understood it, if they interpreted it correctly, and if they are going to reply immediately, never, or sometime in between.

### Sometimes, You Just Need an Answer

Traditionally, standup serves the purpose of a synchronizing point across a handful of individuals.
It's been synchronous for a reason.

There's an urgent issue that needs someone's attention immediately.
That's not the time where you want to message someone on Slack and pray they see it in time.

That's also not the time where you want to tag two or three people on a thread and hope that one of them not only volunteers to jump on it, but also has done so in a timely manner.
As a team lead, manager, or Bossman, you need to get an answer.

If it's some shit assignment that honestly no one wants to do, you need to be able to call people out and get someone to accept that they are going to do it.
Or, even if it's something that anyone would be happy to take on, you will have times where no one volunteers because each person already has something they're working on and assumes that someone else is in a better position for it.

You also don't want one person to agree to two different top priority tasks.
Likewise, you don't want two different people to agree to do the same work (or even worse, contradictory work).
Sometimes, you really do need to tell someone, "No, you are not doing this. You need to do that instead."

When trying to coordinate asynchronously, the longer things go before everyone is on the same page, the further off-course everyone can get.
And it's not a linear drift; each person involved can end up being a chaos multiplier.

### The Less Open Loops, The Better

The more open loops you have, the more overhead you have to deal with.
Some of this comes in the form of more context switches, more frequent message checking, more interruptions, more notes to take about more things in flight.
Some of it comes in the form of just not being able to get work across the finish line and unexpected or unplanned work landing on your plate.
Plenty of it comes as just more stress and anxiety.

It's pretty widely understood that minimizing work in progress leads to better quality work, and more work getting done over time.
I think we need to expand our definition of what counts as "work in progress", and minimize that.
