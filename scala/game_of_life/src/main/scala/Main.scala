object Main extends App {
  val messageQueue = new MessageQueue()
  val grid = Grid.create(3, messageQueue)

  grid.seed(3)
  println(grid)

  grid.tick()
  println(grid)

  grid.tick()
  println(grid)
}
