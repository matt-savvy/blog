%{
  title: "Mnemonic Data Structures",
  author: "Matt",
  tags: ~w(mnemonics),
  description: "Using the right data structure for the job is always important, especially when storage and lookup happens in your brain."
}
---

Using the right data structure for the job is always important, especially when storage and lookup happens in your brain.

## Mnemonics Crash Course

Mnemonics are techniques used to aid your memory, and with a little bit of practice, can allow you to remember a seemingly superhuman amount of information.
Mnemonics can be used for anything from remembering where you parked to memorizing the phone book.
There are many different techniques, but they all leverage two basic principles: encoding and association.

**Encoding** is simply taking things that are difficult for the human brain to remember and representing them as things that are easier to remember.
**Associating** is then how we "write" this encoded data to our brain.

## Linked List

Possibly the easiest data structure to implement in either code or your mind is the classic linked list.
Each item in the list represents some value and is linked to another item or the end of the list.

How it works in your brain is pretty similar; each item represents itself and points to the next item in the list.
Let's say you need to remember a few things to get at the store: peanut butter, light bulbs, and carrots.
Close your eyes and imagine a jar of peanut butter the size of a building.
Next, picture the lid off, the jar is filled to the top, and then a light bulb is jammed into the peanut butter and threaded into the peanut butter.
See the bulb light up.
Next, visualize the top of the bulb shatter as carrots fly out like artillery fire.

To read the list, you start at the first item and play through the sequence in your mind.
This is basic association at work.
The peanut butter points to the light bulbs and the light bulbs point to the carrots.
In this basic technique, you represent each item as itself, so there's very minimal encoding.

To remember the first item at the list, you just need to make a connection between the store itself and the first item of the list.
You can try imagining that you walk up to the store but the store itself is squashed by that building-sized jar of peanut butter we first pictured.

The time complexity for both access and search is `O(n)` - the longer the list grows, the more items you need to play through in your mind.
The good news is that there's no fixed-length issues.
You can let the list grow to an arbitrary length.

Linked lists are ideal for shorter, ad-hoc or one-off lists.
They're also great for memorizing long numbers, but you'll need to know how to encode digits.

## Memory Palaces

Also known as *method of loci*, memory palaces can allow random access, but requires more up-front investment.

The basic approach has you visualize some physical location that you know very well.
Before you're ready to start writing to it, you need to select a number of distinct locations in this place and the order you'll step through them.

For example, my go-to memory palace is a house I used to live in.
The first few locations are, in order:
1. Garbage cans out front
2. Steps leading up to the front door
3. Vestibule
4. Just inside the living room
5. Base of the stairs

Once your palace is prepared, you write to it by imagining the first item in the first location, second item in the second location, all the way through.
To read the entire list, you start at the beginning, and visualize stepping through each location in the palace and "seeing" what item is there.
But, since you know all the locations ahead of time, it's no more expensive to start at the end of the list and work your way forwards.
A memory palace has `O(1)` time complexity for accessing the item at any given location.
If you know what location you left off at, appending to the list is also a constant time operation.

And, if you are really prepared, you'll know the index number of each location and will be able to index into the memory palace in constant time.
Unfortunately, search is still an `O(n)` operation since you need to step through the whole list.

Once you have a memory palace ironed out, you can re-use it for many different things for years to come.

## Peg System

The peg system is a little more advanced and requires more overhead, but unlocks the next tier.
It's essentially a dictionary, where the keys are encoded natural numbers and the values are the items that you want to remember.

We encode the numbers because numbers are fairly abstract and hard to visualize.
For example, can your mind's eye clearly picture thirty-five of something?
Can it tell the difference between that and thirty-four or thirty six?

The common way to encode numbers is to take each digit and map it to a phonetic sound (there are a few different common systems).
Those sounds "spell" a word.
This word is your key, so you want it something that you can easily visualize.
Finally, you associate your key with your value, in the same way we did when creating our linked list.

I won't explain the whole encoding system (see [The Memory Book](https://www.goodreads.com/en/book/show/349426) for this and more) but I will give a few examples.

The number sixteen maps to the word "touch", which I visualize as reaching out and touching like ET, with a single long finger extended.
What are you picturing touching?
Whatever the item you want to remember is in the first place!
In our case, we imagine that we're reaching up and touching the giant statue of Abraham Lincoln at the Lincoln Memorial.
This is how I can tell you that Abe Lincoln was the sixteenth President of the United States.

The number thirty-one maps to the word "mitt", which I picture as a giant baseball mitt, holding on to something.
What is it holding on to?
I'm sure you already guessed it, the item at position thirty-one!
In this case, I see a disembodied baseball mitt, holding onto the handle of an upright vacuum cleaner, pushing it back and forth.
This is how I remember that Herbert Hoover was the thirty-first President.

Since we can read the value at any arbitrary index, we can say that a peg system allows access with a time complexity of `O(1)`.
The space is also only limited by how many numbers we can consistently encode to the same keys.

## More About Encoding

In the last example, the two values we found were Abe Lincoln and Herbert Hoover.
The first is easy because we *know* what Lincoln looks like.
Herbert Hoover on the other hand, not a clue.
Could not pick this man out of a lineup.

This is where encoding comes in.
What is something else called Hoover that we could visualize?
Hoover is one of the most famous brands of vacuum cleaners (and in the UK, they don't even say "vacuum" or "vacuum cleaner", they just say "hoover").
So we take something we can't visualize, encode it as something that we easily can, and associate our key to that image.

### Bonus Round: PAO Encoding

PAO means Person, Action, Object.
It's an encoding technique that allows you to remember a fixed set of ordered items in a third of the space.
The context I first learned it in was memorizing the order of a deck of playing cards.

The way it works is that you take a fixed set of items, for example, each card in the deck, and you decide a person to associate with this item as well as the action and object that best represents them.
Then, you take a group of three items, you use the person that represents the first item, imagine them doing the action that represents the second, and they're doing it to the object that represents the third.

Let's say the 7 of Spades is Mario.
His action is his trademark jump with one fist in the air.
And the object is a classic green pipe.

The Ace of Diamonds is Captain America, his action is a disc throw, and the object that he's throwing is his shield.

And the 7 of Diamonds is Arnold Schwarzenegger, bench pressing a barbell that's loaded up with plates.

So you encode these three cards, in order, by imagining Mario doing a Frisbee toss with a barbell.
Now that you've encoded three cards as one small scene, you drop that in the first location of your memory palace.

You would remember the order of the rest of the deck by taking the next three items, combining the person, action, and object in the same way, and imagining them in the second location of your memory palace.

This encoding technique allows you to fit 52 items in 18 places.
There is a significant amount of overhead involved setting up the system, but the payoff can be worth it.

## Cheat Sheet

### Linked List

Best for ad-hoc lists and (encoded) long-digit numbers.

- access - `O(n)`
- write - `O(n)`

### Memory Palace

Best for sets and lists below a fixed-length. Some preparation required.

- access - `O(1)`
- write - `O(n)` average, best case `O(n)`

### Peg System

Best for key-value pairs, especially when the key is a number. Some preparation required.

- access - `O(1)`
- write - `O(1)`

## Further Reading

[The Memory Book](https://www.goodreads.com/en/book/show/349426)
The classic book that got me interested in mnemonics.

[Moonwalking with Einstein: The Art and Science of Remembering Everything](https://www.goodreads.com/en/book/show/6346975)
A personal account that takes you into the world of competitive memorization, teaching you some techniques along the way.
