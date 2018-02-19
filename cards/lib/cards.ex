defmodule Cards do

 #run shell with iex -S mix
 # run file with Cards.fx name

  def help do
    "hello, there! This module provides functions for creating deck, shuffling, checking if card is in deck, "
  end

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits  = ["Spades", "Hearts", "Diamonds", "Clubs"]

    #calling bad method for generating list
    #cards = doubleLoopDeckGeneration(values, suits)
    #List.flatten(cards)

    # list comprehension for iterating over lists. Its a for loop essentially.
    cards = doubleComprehension(values,suits)
    cards
  end

  #iterates over both the lists sequentially. No Need to flatten list here as no other lists will be generated
  def doubleComprehension(values, suits) do 
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  #nested double loop --  bad approach as O(n^2)
  def doubleLoopDeckGeneration(values, suits) do
    for value <- values do
      for suit <- suits do
      # we can create a nested for loop here for generating 
      "#{value} of #{suit}"
     
      end
    end
  end
  
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do 
    Enum.member?(deck, card)
  end

  # Output would be in form of tuple {[hand to be returned], [rest of the cards in given deck]}
  def deal(deck, cardsToBeDealt) do
    Enum.split(deck, cardsToBeDealt)
  end

  def save(deck, filename) do 
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  # load by using atoms
  def load1(filename) do
    {status, binary} = File.read(filename)
    case status do 
      :ok -> :erlang.binary_to_term binary
      :error -> "File does not exist"
      _ -> "File not found"
    end
  end
  # load by using comparison and assignment - 2 steps at a time
  def load2(filename) do
    case File.read(filename) do 
      {:ok, binary} -> :erlang.binary_to_term binary
      # check optional body of error as it is in form of tuple by using _ which is for optional element which we dont care
      {:error, _} -> "File does not exist"
      
    end
  end

  def create_hand_without_pipe(hand_size) do
    deck =  Cards.create_deck 
    deck =  Cards.shuffle(deck) 
    hand =  Cards.deal(deck,hand_size)
  end
  #using Pipe operator to remove mundane code. NOTE: Pipe operator ALWAYS APPLIES AS FIRST ARGUMENT ONLY.
  def create_hand(hand_size) do 
       Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
