class Game
  constructor: (@cells, @columns, @rows) ->
    @current = @eachCell @cells, (x, y) =>
      i = y * @columns + x
      @cells.itemAt(i)
    @setNeighbors()


  eachCell: (cells, f) ->
    for y in [0...@rows]
      for x in [0...@columns]
        f(x, y)


  iterate: ->
    tmp = @eachCell @current, (x, y) =>
      cell = @current[y][x]
      aliveNeighbors = cell.neighbors.filter (nb) -> nb.isAlive
      cell.numberOfAliveNeighbors = aliveNeighbors.length
      n = aliveNeighbors.length
      if n < 2 or n > 3
        false
      else if n == 3
        if !cell.isAlive
          i = [
            [0,1,2]
            [0,2,1]
            [1,0,2]
            [1,2,0]
            [2,0,1]
            [2,1,0]
          ][Math.floor(Math.random()*6)]
          cell.r = aliveNeighbors[i[0]].r
          cell.g = aliveNeighbors[i[1]].g
          cell.b = aliveNeighbors[i[2]].b
        true
      else
        cell.isAlive

    @eachCell @current, (x, y) =>
      @current[y][x].isAlive = tmp[y][x]


  setNeighbors: ->
    @eachCell @current, (x, y) =>
      left = (x+@columns-1) % @columns
      right = (x+1) % @columns
      up = (y+@rows-1) % @rows
      down = (y+1) % @rows
      @current[y][x].neighbors = [
        @current[up][left]
        @current[up][x]
        @current[up][right]
        @current[y][left]
        @current[y][right]
        @current[down][left]
        @current[down][x]
        @current[down][right]
      ]
