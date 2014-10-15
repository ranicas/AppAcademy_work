# encode UTF 8

class SlidingPiece < Piece
  # DIRECTION_DELTAS = [[0, 0]]

  def moves
    moves = []

    move_dirs.each do |delta|
      shift = delta

      (1..7).each do |mul|
        shift = [delta[0] * mul, delta[1] * mul]
        new_pos = shift_by(shift)

        if !in_bounds?(new_pos) || occupied_by_friend?(new_pos)
          break
        elsif occupied_by_enemy?(new_pos)
          moves << new_pos
          break
        else
          moves << new_pos
        end
        
      end
    end

    moves
  end





  # def valid_move?(new_pos)
  #   #checking color
  #   if not empty && same color
  #     return -1

  #   elsif not empty && dif color
  #     return 1
  #   else
  #     return 0
  #   end
  #   board.empty_space?(shift_by(shift))
  # end


end 
