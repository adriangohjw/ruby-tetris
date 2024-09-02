# frozen_string_literal: true

require_relative 'game'

DEMO = {
  initial_blocks: [
    { position: 0, type: ONE_DOT },
    { position: 1, type: ONE_DOT },
    { position: 3, type: ROW_OF_3 },
    { position: 3, type: NORMAL_L },
    { position: 3, type: NORMAL_L },
    { position: 2, type: ONE_DOT },
    { position: 2, type: INVERTED_T },
    { position: 1, type: ROW_OF_3 },
    { position: 4, type: ONE_DOT },
    { position: 2, type: NORMAL_Z },
    { position: 4, type: NORMAL_Z },
    { position: 2, type: NORMAL_Z },
    { position: 1, type: ONE_DOT },
    { position: 4, type: NORMAL_T },
    { position: 4, type: COLUMN_OF_3 },
    { position: 2, type: NORMAL_T },
    { position: 0, type: INVERTED_T },
    { position: 1, type: ROTATED_L },
    { position: 3, type: INVERTED_T },
    { position: 0, type: ONE_DOT, moves: [RIGHT, RIGHT, DO_NOTHING, LEFT] },
    { position: 1, type: ONE_DOT, moves: [RIGHT, RIGHT, RIGHT, RIGHT, RIGHT, RIGHT] }
  ],
  rows: 15,
  columns: 6
}.freeze

test = DEMO
Game.new(
  number_of_rows: test[:rows],
  number_of_columns: test[:columns],
  list_of_blocks: test[:initial_blocks]
).call
