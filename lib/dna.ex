defmodule Dna do
  require Logger

  def count_letters(dna_list) do
    start_count = %{ A: 0, C: 0, G: 0, T: 0 }

    Enum.reduce(dna_list, start_count, fn(letter, count_map)->
      { _, updated_count } = Map.get_and_update( count_map, String.to_atom(letter), fn(current_count)->
        {current_count, current_count + 1}
      end)
      updated_count
    end)
  end


  def count_letters_parallel(dna_list) do
    number_of_workers = 2
    size_of_chunk = length(dna_list)/number_of_workers |> round
    dna_chunks = Enum.chunk( dna_list, size_of_chunk )

    worker_ids = Enum.map(dna_chunks, fn(chunk)->
      Task.async(Dna, :count_letters, [chunk])
    end)

    joined_count = %{A: 0, C: 0, G: 0, T: 0}

    Enum.reduce(worker_ids, joined_count, fn(worker_id, count_map)->
      result = Task.await( worker_id )
      Map.merge(count_map, result, fn(_k, v1, v2)->  v1 + v2 end)
    end)
  end

end
