# frozen_string_literal: true

require_relative 'game'

# test row clearing
TEST_1 = {
  initial_blocks: [
    { position: 0, type: ONE_DOT },
    { position: 1, type: ONE_DOT },
    { position: 2, type: ONE_DOT },
    { position: 3, type: ONE_DOT },
    { position: 4, type: ONE_DOT },
    { position: 1, type: ONE_DOT }
  ],
  rows: 5,
  columns: 5
}.freeze

# test for gameover
TEST_2 = {
  initial_blocks: [
    { position: 1, type: ONE_DOT },
    { position: 1, type: ONE_DOT },
    { position: 1, type: ONE_DOT },
    { position: 1, type: ONE_DOT },
    { position: 1, type: ONE_DOT },
    { position: 1, type: ONE_DOT }
  ],
  rows: 5,
  columns: 5
}.freeze

TEST_3 = {
  initial_blocks: [
    { position: 0, type: ROW_OF_3 },
    { position: 3, type: ROW_OF_3 },
    { position: 1, type: ROW_OF_3 },
    { position: 1, type: ROW_OF_3 }
  ],
  rows: 6,
  columns: 6
}.freeze

TEST_4 = {
  initial_blocks: [
    { position: 0, type: COLUMN_OF_3 },
    { position: 0, type: COLUMN_OF_3 },
    { position: 1, type: COLUMN_OF_3 },
    { position: 2, type: COLUMN_OF_3 },
    { position: 3, type: COLUMN_OF_3 },
    { position: 4, type: COLUMN_OF_3 },
    { position: 5, type: COLUMN_OF_3 },
    { position: 0, type: COLUMN_OF_3 }
  ],
  rows: 6,
  columns: 6
}.freeze

TEST_5 = {
  initial_blocks: [
    { position: 1, type: NORMAL_T },
    { position: 1, type: NORMAL_T },
    { position: 4, type: NORMAL_T },
    { position: 4, type: NORMAL_T },
    { position: 2, type: NORMAL_T },
    { position: 3, type: NORMAL_T }
  ],
  rows: 6,
  columns: 6
}.freeze

TEST_6 = {
  initial_blocks: [
    { position: 0, type: INVERTED_T },
    { position: 0, type: INVERTED_T },
    { position: 3, type: INVERTED_T },
    { position: 3, type: INVERTED_T },
    { position: 1, type: INVERTED_T },
    { position: 2, type: INVERTED_T }
  ],
  rows: 6,
  columns: 6
}.freeze

TEST_7 = {
  initial_blocks: [
    { position: 0, type: NORMAL_L },
    { position: 0, type: NORMAL_L },
    { position: 3, type: NORMAL_L },
    { position: 3, type: NORMAL_L },
    { position: 1, type: NORMAL_L },
    { position: 2, type: NORMAL_L }
  ],
  rows: 6,
  columns: 6
}.freeze

TEST_8 = {
  initial_blocks: [
    { position: 0, type: ROTATED_L },
    { position: 0, type: ROTATED_L },
    { position: 3, type: ROTATED_L },
    { position: 3, type: ROTATED_L },
    { position: 1, type: ROTATED_L },
    { position: 2, type: ROTATED_L }
  ],
  rows: 6,
  columns: 6
}.freeze

TEST_9 = {
  initial_blocks: [
    { position: 1, type: NORMAL_Z },
    { position: 3, type: NORMAL_Z },
    { position: 2, type: NORMAL_Z },
    { position: 4, type: NORMAL_Z },
    { position: 2, type: NORMAL_Z },
    { position: 4, type: NORMAL_Z }
  ],
  rows: 6,
  columns: 6
}.freeze

TEST_10 = {
  initial_blocks: [
    { position: 0, type: ONE_DOT, moves: [RIGHT, RIGHT, DO_NOTHING, LEFT] },
    { position: 1, type: ONE_DOT, moves: [RIGHT, RIGHT, RIGHT, RIGHT, RIGHT, RIGHT] },
    { position: 2, type: ONE_DOT },
    { position: 3, type: ONE_DOT },
    { position: 4, type: ONE_DOT },
    { position: 1, type: ONE_DOT }
  ],
  rows: 5,
  columns: 5
}.freeze

test = TEST_10
Game.new(
  number_of_rows: test[:rows],
  number_of_columns: test[:columns],
  list_of_blocks: test[:initial_blocks]
  # production: false
).call
