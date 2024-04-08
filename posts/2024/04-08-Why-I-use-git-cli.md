%{
  title: "Why I use Git on the command line",
  author: "Matt",
  tags: ~w(git),
  description: "Why I use Git on the command line (and maybe why you should too)"
}

---

Anyone who has paired with me or watched me give a demo has watched me rely on the plain Git CLI, and maybe wondered why I don't use a fancy client or plugin.

## It Makes You Understand

First things first.
Most professional developers have almost no idea what they're doing with Git.
If the primary way they interact with Git is through a GUI (like the default plugin in their editor), they probably have a very flimsy mental model.

I speak from personal experience, because I used Git for years, first using the OSX Github Desktop client, and then later relying on the Git plugin that shipped with Atom.
And I honestly really never understood what I was doing (and more importantly, what Git was doing) until I gave up and adopted using the command line for everything.

Even if you find a Git client or plugin more convenient, you can learn a lot if you just challenged yourself to only using the plain command line client for one month.

## It's always there

You know what they say, it's better to have it and not need it then need it and not have it.
And that goes for your tooling.

If you are 100% reliant on the interface of your Git plugin or client, how well can you operate when it's not there?
What happens when you a working with someone on their machine and you encounter an issue?
What if you only know how to resolve that using some button on your plugin, but you don't actually know what it is that the button is doing for you?

## Plugins and Clients change

The editor du jour changes, the clients can fall into an unmaintained status.
But the Git CLI isn't going anywhere as long as version control is going to be around.

Personally, I am a big fan of learning something once and being able to consider that an evergreen skill.

## It's Scriptable

With a given client or plugin, you only have access to the actions and workflows that the authors decided upfront.
But if you feel at home with all the basic commands (and maybe some not-no-basic ones), you can easily write a script to automate your own workflows.

## Everything is at your disposal

Any client's interface is only going to expose so much.
However, the Git CLI exposes it all and then even some more than it probably should.

And if your mental model is accurate enough, it's not much of a leap to accomplish things that are unthinkable in your average plugin.

For example:
- Edit any commit's changes or message.
- Take all the changes for a branch and build up your commits from scratch, now that you know how you want to solve the problem.
- View a diff of a file across two different branches, even if it's been renamed.
- Stash all your changes, but also keep what you have staged.
- List only the test files that are different than your `develop` branch, and run only those tests.
- See all of the commits where a function name was referenced, added or removed.
Great for those "Do we really not use this anymore?" investigations!
- Reorder your commits on the fly.
- Find the commit that introduced a bug.
- View all of the commits (or the entire diff) that a release introduces.

And most anything else you can imagine.

Maybe you're reading this and thinking these are contrived examples, but these are all normal things that I have done, do, and will probably do again.
When you feel comfortable with the operations you have at your disposal, you can begin to really understand your code as having a whole nother dimension.
The more you do that, the more you realize that you can easily do, the more ways you can solve your problem.

And there's no better way to refine your mental model than just playing around.
