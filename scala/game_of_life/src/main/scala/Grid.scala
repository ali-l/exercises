import scala.util.Random

object Grid {
  def create(size: Int, messageQueue: MessageQueue): Grid = {
    val cells =
      for (row <- 0 until size; col <- 0 until size)
        yield new Cell(row, col, messageQueue.insert)

    new Grid(cells, size, messageQueue.flush)
  }
}

class Grid(val cells: IndexedSeq[Cell], size: Int, flushMessages: () => List[Message]) {
  override def toString: String = cells.toString

  def seed(n: Int): Unit = {
    for (_ <- 0 until n) {
      val index = Random.nextInt(cells.length)
      if (!cells(index).isAlive) cells(index).setAlive(true)
    }

    distributeMessages()
  }

  def tick(): Unit = {
    updateLivingState()
    distributeMessages()
  }

  private def updateLivingState(): Unit = {
    cells.foreach { cell => cell.updateLivingState() }
  }

  private def distributeMessages(): Unit = {
    flushMessages().foreach { message =>
      possibleNeighbours(message.row, message.col)
        .filter { coords => isInBounds(coords._1, coords._2) }
        .map { coords => coordsToIndex(coords._1, coords._2) }
        .foreach { index => cells(index).processMessage(message) }
    }
  }

  private def isInBounds(row: Int, col: Int): Boolean = {
    row >= 0 && row < size && col >= 0 && col < size
  }

  private def possibleNeighbours(row: Int, col: Int): List[(Int, Int)] = {
    List(
      (row - 1, col - 1),
      (row - 1, col),
      (row - 1, col + 1),
      (row, col - 1),
      (row, col + 1),
      (row + 1, col - 1),
      (row + 1, col),
      (row + 1, col + 1),
    )
  }

  private def coordsToIndex(row: Int, col: Int) = row * size + col
}
