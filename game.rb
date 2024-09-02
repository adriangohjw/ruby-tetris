# frozen_string_literal: true

ONE_DOT = :one_dot
ROW_OF_3 = :row_of_three
COLUMN_OF_3 = :column_of_three
NORMAL_T = :normal_t
INVERTED_T = :inverted_t
NORMAL_L = :normal_l
ROTATED_L = :rotated_l
NORMAL_Z = :normal_z

LEFT = -1
DO_NOTHING = 0
RIGHT = 1

class Game
  def initialize(
    number_of_rows: 6,
    number_of_columns: 6,
    list_of_blocks: [],
    production: true
  )
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    @list_of_blocks = list_of_blocks.dup
    @production = production
    @interval = @production ? 0.5 : 0.15
    @initial_row = @number_of_columns.times.inject([]) { |acc, _| acc << 0 }
    @grid = @number_of_rows.times.inject([]) { |acc, _| acc << @initial_row.dup }
    @current_block_cords = []
    @current_block_moves = []
  end

  def call
    retrieve_next_block
    loop do
      print_grid
      if update_current_block
        clear_filled_rows
      else
        merge_current_with_grid
        clear_filled_rows
        retrieve_next_block
      end
      sleep @interval
    end
  end

  def retrieve_next_block
    current_block = @list_of_blocks.shift
    if current_block.nil?
      pp 'No more block, game ended 👍'
      exit
    end

    @current_block_cords = []
    position = current_block[:position]
    case current_block[:type]
    when ONE_DOT
      # 0 x 0 0 0
      @current_block_cords << [0, position]
    when ROW_OF_3
      # 0 x x x 0
      @current_block_cords << [0, position]
      @current_block_cords << [0, position + 1]
      @current_block_cords << [0, position + 2]
    when COLUMN_OF_3
      # 0 x 0 0 0
      # 0 x 0 0 0
      # 0 x 0 0 0
      @current_block_cords << [0, position]
      @current_block_cords << [-1, position]
      @current_block_cords << [-2, position]
    when NORMAL_T
      # 0 x x x 0
      # 0 0 x 0 0
      @current_block_cords << [0, position]
      @current_block_cords << [-1, position - 1]
      @current_block_cords << [-1, position]
      @current_block_cords << [-1, position + 1]
    when INVERTED_T
      # 0 0 x 0 0
      # 0 x x x 0
      @current_block_cords << [0, position]
      @current_block_cords << [0, position + 1]
      @current_block_cords << [0, position + 2]
      @current_block_cords << [-1, position + 1]
    when NORMAL_L
      # 0 x 0 0 0
      # 0 x 0 0 0
      # 0 x x 0 0
      @current_block_cords << [0, position]
      @current_block_cords << [0, position + 1]
      @current_block_cords << [-1, position]
      @current_block_cords << [-2, position]
    when ROTATED_L
      # 0 0 0 x 0
      # 0 x x x 0
      @current_block_cords << [0, position]
      @current_block_cords << [0, position + 1]
      @current_block_cords << [0, position + 2]
      @current_block_cords << [-1, position + 2]
    when NORMAL_Z
      # 0 x x 0 0
      # 0 0 x x 0
      @current_block_cords << [0, position]
      @current_block_cords << [0, position + 1]
      @current_block_cords << [-1, position - 1]
      @current_block_cords << [-1, position]
    end
    @current_block_moves = current_block[:moves] || []

    pp '✨ Adding new block ✨' unless @production
    @current_block_cords.each do |cord|
      _x, y = cord
      cannot_insert_block = @grid[0][y] == 1
      if cannot_insert_block
        pp 'Cannot add new block, gameover 👎'
        exit
      end
    end
  end

  def print_grid
    temp_grid = @grid.map(&:dup)
    @current_block_cords.each do |cord|
      x, y = cord

      not_shown_on_screen = x.negative?
      next if not_shown_on_screen

      temp_grid[x][y] = 1
    end
    if @production
      Gem.win_platform? ? system('cls') : system('clear')
    else
      pp '---------------------------'
    end
    temp_grid.each { |row| pp row }
  end

  def clear_filled_rows
    temp_grid = []
    number_of_cleared_rows = 0
    @grid.each do |row|
      if row.sum == @number_of_columns
        number_of_cleared_rows += 1
      else
        temp_grid << row
      end
    end
    number_of_cleared_rows.times { temp_grid.unshift(@initial_row.dup) }
    @grid = temp_grid
  end

  # we execute moves before shifting down
  def update_current_block
    execute_block_move
    move_block_down
  end

  def execute_block_move
    current_move = @current_block_moves.shift
    return if current_move.nil?
    return if current_move == DO_NOTHING

    new_cords = []
    @current_block_cords.each do |cord|
      x, y = cord

      next_cord = @grid[x][y + current_move]
      cannot_move = next_cord.nil? || next_cord == 1
      return false if cannot_move

      new_cords << [x, y + current_move]
    end
    @current_block_cords = new_cords
  end

  def move_block_down
    new_cords = []
    @current_block_cords.each do |cord|
      x, y = cord

      at_the_floor_row = x == @number_of_rows - 1
      return false if at_the_floor_row

      next_row_is_onscreen = x + 1 >= 0
      if next_row_is_onscreen
        cannot_be_added_to_next_row = @grid[x + 1][y] == 1
        return false if cannot_be_added_to_next_row
      end

      new_cords << [x + 1, y]
    end
    @current_block_cords = new_cords
  end

  def merge_current_with_grid
    new_grid = @grid.map(&:dup)
    @current_block_cords.each do |cord|
      new_grid[cord[0]][cord[1]] = 1
    end
    @grid = new_grid
  end
end
