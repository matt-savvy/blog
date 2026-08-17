%{
  title: "Writing My Own Time-Based One-Time Password Generator",
  author: "Matt",
  tags: ~w(zig),
  description: "Creating a tool to generate authentication codes straight from the command line."
}
---

For some reason, I’ve always wanted to write my own authenticator.
I vaguely knew how these Time-based One Time Passwords worked, and decided to go deeper.
Instead of going to any secondary sources, I implemented the algorithms straight from the RFCs.

Before this, I'd personally never sat down and just read through an RFC top to bottom, let alone executed what's described with no other references.
It was a rewarding experience, something that I'm sure used to be commonplace, but that now an entire generation of programmers has been insulated from.

## Why A Command Line Authenticator?

For years, I'd used [oathtool](https://oath-toolkit.codeberg.page/oathtool.1.html) for this so that I could get these 2FA codes on the command line and pipe them into my clipboard.
For many people, 2FA/MFA is the reason they give for having their phone in their workspace, which sabotages their ability to focus.
During the work day, my phone is downstairs, plugged in, instead of with me.
Before I discovered oathtool, whenever I needed to do a 2FA, I would go downstairs, get a code, and try to get back upstairs to my office quick enough to beat the clock.

## How do Time-Based One Time Passwords work?
[RFC-6238](https://www.rfc-editor.org/info/rfc6238/) presents the Time-Based OTP (TOTP), which builds on [RFC-4226](https://www.rfc-editor.org/info/rfc4226/) for the HMAC-Based OTP (HMAC).

The time-based OTP alg is pretty cool.
Essentially, it takes a shared secret and a shared start time (usually the Unix epoch), interval size (usually 30s), and number of digits (usually 6).
When you need a password, you calculate how many intervals have passed since the shared start time, and use that as the input to the HOTP (HMAC based one-time password).

The HOTP is a similar idea, except using a shared counter instead of time offset.
You use an HMAC alg on the secret and input value to get a hash.
You look at a certain byte, its value tells you where to grab other bytes from, you do a little math, and you end up with a 6 digit code.

This is how your authenticator apps are always ticking away and can generate a secret even if you have no signal.

## Putting It Into Action

Since the goal was a command line program that involves manipulating things at the byte level, Zig was a perfect fit.
I've been dabbling with Zig here and there for a while now and am always looking for a place to use it.
Zig’s std lib has the HMAC functions and algorithms, so fortunately/sadly I did not have to implement those from scratch.

However, as soon as I started rounding up secret keys, I noticed they all seem to be provided in Base32, which means I needed a Base32 decoder, which the std lib does not (yet) include.
I deliberately did not want to reach for a library, so instead of looking for one, I went back to the RFCs.

[RFC-4648](https://www.rfc-editor.org/info/rfc4648/#section-6) specifies the Base16, Base32, and Base64 data encodings.
Again working from the RFC, I implemented (most of) a Base32 decoder.

Base32 is an encoding you can use to encode arbitrary bytes into ASCII, where the end result will be represented by the characters A-Z (uppercase only) and the digits 2-7.
To decode, you break the input stream into groups of 8 Base32 chars, each char represents a 5-bit value, and then you treat that 8 x 5-bit group as a 5 x 8-bit group.
I did this by putting 8 `u5` values into a packed struct and then `@bitCasting` into a `[5]u8`.
I doubt this is the most effective way to do it, but I thought it was a fun opportunity to use Zig’s arbitrarily-sized integers.

I only handle cases where the encoded data fits evenly into the Base32 chars, because that’s really all I need.
If someone gives me a secret key with the padding `=` chars, I'm sure I’ll handle it then.

Besides just the satisfaction of writing it myself and knowing how it works, it's nice to have something that does exactly what you need and nothing else.
I'm only decoding, so there's no unused code to handle encoding.
I'm only decoding Base32, so there's need for a flexible API to accomodate Base16 or Base64.

## The End Result

It turned out to be a fun project, and a gratifying experience to go directly to the primary sources.
It’s still rough around the edges and I haven’t implemented all the options, but it’s working for me and gives me a little satisfaction every time I need to generate a 2FA now.

```sh
$ cat some-key | totp
985403
```

[github:matt-savvy/totp](https://github.com/matt-savvy/totp)

