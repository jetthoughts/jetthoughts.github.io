---
dev_to_id: 1880218
title: Help shepherd to count sheep in Elixir
description: I have been thinking about learning a functional language for a long time. So recently I’ve started...
created_at: '2024-06-07T10:14:43Z'
edited_at: '2024-10-22T21:06:24Z'
draft: false
tags:
- programming
- elixir
- codewars
- tutorial
canonical_url: https://jetthoughts.com/blog/help-shepherd-count-sheep-in-elixir-programming/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/help-shepherd-count-sheep-in-elixir-programming/cover.jpeg
slug: help-shepherd-count-sheep-in-elixir-programming
metatags:
  image: cover.jpeg
---
![Shepard (Mass Effect)](file_0.jpeg)

I have been thinking about learning a functional language for a long time. So recently I’ve started to play around with Elixir. I am reading official guide and docs for theory. And also I do simple katas on Codewars for practice.

The last kata is [**Counting sheep…](https://www.codewars.com/kata/counting-sheep-dot-dot-dot/train/elixir) **And I’ve come up with 13 solutions for it. Let me show it to you and explain why I need so many.

### Task

Consider an array of sheep where some sheep may be missing from their place. We need a function that counts the number of sheep present in the array (true means present).

For example,

    [true,  true,  true,  false,
      true,  true,  true,  true ,
      true,  false, true,  false,
      true,  false, false, true ,
      true,  true,  true,  true ,
      false, false, true,  true]

The correct answer would be 17.

### Solution boilerplate

```elixir

defmodule Shepherd do
  def count_sheeps(sheeps) do
    # TODO: for Elixir only true/false values can be presented the in sheeps list
  end
end
```

### Sample Tests

```elixir
defmodule TestShepherd do
  use ExUnit.Case
  import Shepherd, only: [count_sheeps: 1]

  test "work for some examples" do
    assert count_sheeps([]) == 0
    assert count_sheeps([true]) == 1
    assert count_sheeps([true, false]) == 1
    assert count_sheeps([false, false]) == 0
    assert count_sheeps(
    [true,  true,  true,  false,
     true,  true,  true,  true ,
     true,  false, true,  false,
     true,  false, false, true]) == 11
  end
end
view raw
```

### My solutions

```elixir
defmodule ShepherdHeadTail do
  def count_sheeps([]), do: 0

  def count_sheeps(sheeps) do
    [head | tail] = sheeps
    count_sheeps(tail) + (if head, do: 1, else: 0)
  end
end

defmodule ShepherdAccumulator do
  def count_sheeps(sheeps, accumulator \\ 0)

  def count_sheeps([], accumulator) do
    accumulator
  end

  def count_sheeps([head | tail], accumulator) do
    count_sheeps tail, accumulator + (if head, do: 1, else: 0)
  end
end

defmodule ShepherdIsSheep do
  def is_sheep?(true), do: 1
  def is_sheep?(false), do: 0

  def count_sheeps([]), do: 0

  def count_sheeps([head | tail]) do
    is_sheep?(head) + count_sheeps(tail)
  end
end

defmodule ShepherdIsSheepAccumulator do
  def is_sheep?(true), do: 1
  def is_sheep?(false), do: 0

  def count_sheeps(sheeps, accumulator \\ 0)

  def count_sheeps([], accumulator), do: accumulator

  def count_sheeps([head | tail], accumulator) do
    count_sheeps(tail, is_sheep?(head) + accumulator)
  end
end

defmodule ShepherdFoldl do
  def is_sheep?(true, acc), do: 1 + acc
  def is_sheep?(false, acc), do: acc

  def count_sheeps(sheeps) do
    List.foldl sheeps, 0, &is_sheep?/2
  end
end

defmodule ShepherdCount do
  def count_sheeps(sheeps) do
    Enum.count sheeps, fn x -> x end
  end
end

defmodule ShepherdFilter do
  def count_sheeps(sheeps) do
    Enum.filter(sheeps, fn x -> x end) |> Enum.count
  end
end

defmodule ShepherdGroupBy do
  defp counter(:error), do: []
  defp counter({:ok, list}), do: list

  def count_sheeps(sheeps) do
    # alternative: split_with
    Enum.group_by(sheeps, &(&1)) |> Map.fetch(true) |> counter |> Enum.count
  end
end

defmodule ShepherdMapJoin do
  def count_sheeps(sheeps) do
    Enum.map_join(sheeps, &(if &1, do: "1", else: "")) |> String.length
  end
end

defmodule ShepherdReduce do
  def accumulate(true, acc), do: acc + 1
  def accumulate(false, acc), do: acc

  def count_sheeps(sheeps) do
    Enum.reduce(sheeps, 0, &accumulate/2)
  end
end

defmodule ShepherdSum do
  def count_sheeps(sheeps) do
    Enum.map(sheeps, fn(x) -> if x, do: 1, else: 0 end) |> Enum.sum
  end
end

defmodule ShepherdDuplicate do
  def count_sheeps(sheeps) do
    (sheeps -- List.duplicate(false, length(sheeps))) |> length
  end
end

defmodule ShepherdDelete do
  def count_sheeps(sheeps, acc \\ 0) do
    new_sheeps = List.delete sheeps, true
    if new_sheeps == sheeps do
      acc
    else
      count_sheeps new_sheeps, acc + 1
    end
  end
end
```

When I first saw this kata I had very small grasp on how to solve it or cycle through a list in Elixir in general. So I had to look for some clues in guides.

Also during my little investigation I browsed docs on *Enum* and *List *and I was curious to try few functions from there too. Lastly, while I am still on that task I decided to try out syntax peculiarities of Elixir that I already read about.

So this ends my little story on learning a new language. I think this is an interesting approach: take a relatively simple task in a new language and try to solve it in different ways. I see quite a few benefits here.

It would be cool if you propose your solution in comments or share your thoughts on how to learn a new language.
