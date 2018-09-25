object Main extends App {
  val grid = Grid.create(3, new MessageQueue())

  grid.seed(3)
  println(grid)

  grid.tick()
  println(grid)

  grid.tick()
  println(grid)
}
