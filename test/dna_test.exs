defmodule DnaTest do
  use ExUnit.Case
  doctest Dna

  test "can count up letters" do
    dna = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
    dna_list = String.codepoints( dna )
    output = %{
      A: 20,
      C: 12,
      G: 17,
      T: 21
    }
    assert output == Dna.count_letters(dna_list)
  end

  test "can count up letter in parallel" do
    dna = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
    dna_list = String.codepoints( dna )
    output = %{
      A: 20,
      C: 12,
      G: 17,
      T: 21
    }
    assert output == Dna.count_letters_parallel(dna_list)
  end
end
