%{
  title: "The Way We Handle Dependencies Is a Sick Joke",
  author: "Matt",
  tags: ~w(work dependencies),
  description: "Imagine describing to a programmer from the past how we use dependencies today."
}
---

If you went back in time 20 years, found a few working programmers, and described the way we work with third party packages in the year 2025, they would have a good laugh and then ask you, "But seriously, how do you guys really do it?"

First of all, they'd be shocked about how trivial some of these packages are.
Hopefully you aren't coming from the Javascript ecosystem, where it's common to use libraries for a single function.
"Wouldn't it be better to just write it yourself in the first place?" they'd ask.
And they would be right.

Next, they'd wonder what kind of miracles we'd achieved in terms of security and threat analysis that gives us the confidence to download and execute third party code, sight unseen.
And you're going to have to keep a straight face when you tell them, "None, really.
We just download it, hope it's okay, let it do whatever it wants on our machine, and then ship it to our customers."

Then you explain to them how often these get downloaded.
Maybe it's because there was a small patch release, and even though most of the code is unchanged, our system is going to download it all over again anyway.
Or we are just switching branches locally, and most of the popular package ecosystems just never thought of caching these dependencies.
Or maybe it's part of our CI process, which is another can of worms you don't even want to open.
"Isn't that a lot of wasted bandwidth for no reason?" they'd wonder?
You could ask them to guess how much, and they'd be off by a few orders of magnitude.

While they're still trying to wrap their heads around the scale of petabytes per week, you hit them with how often you end up with a tangled, incomprehensible dependency graph of incompatible versions, overrides, and private, unmaintained forks.
They won't comprehend how often one package is pulling in other packages, which pull in even more packages, and so on to infinity.
They won't understand how surprising it is that there are any leaf nodes on this graph at all.

Now that they're starting to get the picture, you need to emphasize how often many of these packages are changing and require versions to be updated.
You make it clear that this is such a problem that we need bots and other automation to keep up with it, that every team either needs to dedicate time to dealing with this on a regular basis, or accept the fact everything will soon be too far gone.
You really can't convey to them how it's normally a lost cause trying to come back to a project that's only a year or two old.
"The future is not looking good for us," your developers of the past think.

Finally, you have to give up and laugh when you point out that usually, no one can really tell you why you have certain dependencies in the first place.
Maybe someone used it for something years ago, it's not even referenced in your code anymore, but everyone is so traumatized by the status quo that they either are afraid to remove it, or just too numb to care.
