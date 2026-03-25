%{
  title: ".claudeignore and the Shared Psychosis of AI Engineering",
  author: "Matt",
  tags: ~w(software-development AI LLM),
  description: "We are witnessing superstitions form in real time."
}
---

There's a lot of problems with `.claudeignore` and Claude Code.
You can find dozens of [issues](https://github.com/anthropics/claude-code/issues?q=is%3Aissue%20claudeignore) on the official Claude Code repo, reporting that the `.claudeignore` file is not being respected.
The agent will bypass it, read from these files, without even giving the user a chance to confirm.
The Register has even reported how Claude Code is reading "off-limits secret files" [^1]

[^1]: [Claude Code's prying AIs read off-limits secret files](https://www.theregister.com/2026/01/28/claude_code_ai_secrets_files/)

These all stem from the same fundamental problem: The `.claudeignore` file is not a feature of Claude Code.

## How I Got Here

Where I work, there's been a bit of a push to integrate agentic AI tools like Claude Code into our workflows.
Part of this has involved us adding `AGENTS.MD` and `.claudeignore` files to some of our repos.

One of these PRs, adding a `.claudeigore` file, came on my list for review.
Looking at this, my first question was pretty basic: what does it mean for something to be listed here?
Does it mean that the LLM won't read the file into its context?
Or that the agent won't have access to those files at all?
That it just won't even know those files exist?
Or something else?

So I did the most obvious thing.
I pulled up the Claude Code docs and searched for `.claudeignore`.
Got a lot of unrelated results, but nothing mentioning this file.

Luckily, the code is open source, so I jumped over to GitHub and just searched the repo.
Zero hits.

I even resorted to asking the LLM integrated with the docs site, and it couldn't find anything for me.

> Based on my search, I couldn't find documentation for a `.claudeignore` file in the Claude code documentation.
> The documentation shows that Claude code uses a different approach for excluding files ...

I brought this back to my team, found who put together the guide recommending adding a `.claudeignore` to our repos, and asked him.
His response was just that he had `.claudeignore` files in his code last year, but it wouldn't surprise him if they had quietly deprecated it.

Wanting to get to the bottom of this, I pulled down the repo and searched the history.

```sh
$ git log -S claudeignore
(END)
```

So the string `claudeignore` never once existed in the project's entire Git history.

## How Did We Get Here?

Was I the first person to stop and even ask the basic question about what this file is expected to do?

Have none of these self-proclaimed AI experts even *read* the documentation for this product?
I see [calls for updates](https://github.com/anthropics/claude-code/issues/16704#issuecomment-4076122961) to the "official docs about `.claudeignore`".
Again, the ones that don't exist.

![Claude users asking for an update to official docs that don't exist](/assets/claude-code-issue.png "Calls for updates to docs that don't exist")

I think my new hobby will be to [troll these issues](https://github.com/anthropics/claude-code/issues/36163#issuecomment-4119437479) until someone admits to me that they opened an issue for something the product never claims to do.

Claude Code itself will assure them that this feature exists, that it's not deprecated, and even offer to add one to the project, but that is no argument.
This is an LLM.
The fact that that Claude "told" you that this existed does not matter.

If you're using Claude Code and you haven't internalized that LLMs generate text and not facts, you have got problems.
This is like crossing the street without understanding that cars are coming.

## 10x Superstitions

There's something deeply rooted in the human brain that makes us find patterns that aren't there.
This comes up even more when dealing with things that are random or just out of our control.

LLMs are a perfect storm here.
They're a black box and they're non-deterministic.

You want to get better results?
Tell it that it's an expert.
Write your instructions in Markdown.
Ask it open-ended questions.
Did any of that work?
Who knows?
Doesn't matter, it won't stop your brain from finding a correlation, whether or not there's one there.

No one can open up the LLM and actually tell you if your changes made it work any better or worse.
Hell, you can't even tell if your changes had any effect.
Maybe you got better results this time, but you can't say for sure if it was because of anything you did differently or if that was just the way the dice landed.

There is one trick[^2] to get some certainty, but it involves running a lot of carefully controlled tests, and even that can only tell you so much.

[^2]: [The Scientific Method](https://en.wikipedia.org/wiki/Scientific_method)

Most of the advice floating around is basically a shared delusion; we're watching urban legends develop, one post at a time.
It's almost not even surprising that every day, someone else is adding an imaginary config file and convincing themselves that it's doing something.
