package game_of_life

import java.util.*

data class Grid(private val rowLength: Int) {
    private val cells = Array(rowLength * rowLength, { Cell(index = it, rowLength = rowLength) { queueBroadcast(it) } })
    private var broadcastQueue = arrayListOf<Message>()

    tailrec fun seed(num: Int, seededIndices: ArrayList<Int> = arrayListOf()) {
        if (num == 0) return
        val index = randomIndex()
        if (seededIndices.any { it == index }) return seed(num, seededIndices)
        queueBroadcast(Message(MessageType.ALIVE, index))
        seededIndices.add(index)
        seed(num - 1, seededIndices)
    }

    fun queueBroadcast(message: Message) {
        cells.forEach { it.process(message) }
    }

    fun dispatchMessages() {
        cells.forEach {
            for (message in broadcastQueue) {
                it.process(message)
            }
        }

        broadcastQueue = arrayListOf()
    }

    fun simulateGeneration() {
        queueBroadcast(Message(MessageType.GENERATION, 0))
        dispatchMessages()
        dispatchMessages()
    }

    private fun randomIndex(): Int {
        return Random().nextInt(rowLength * rowLength)
    }

    override fun toString(): String {
        cells.forEach { println(it) }
        return "foo"
    }
}

data class Cell(private var neighbours: Int = 0, private var alive: Boolean = false, val index: Int, val rowLength: Int, private val broadcast: (Message) -> Unit) {
    fun process(message: Message) {
        when (message.type) {
            MessageType.ALIVE -> becameAlive(message.index)
            MessageType.GENERATION -> simulateGeneration()
        }
    }

    private fun simulateGeneration() {
        if (neighbours == 3) {
            broadcast(Message(MessageType.ALIVE, index))
        }
    }

    private fun isNeighbour(index: Int): Boolean {
        // Left + diagonals unless at beginning of row
        if (this.index % rowLength != 0) {
            if (index == this.index - rowLength - 1) return true
            if (index == this.index - 1) return true
            if (index == this.index + rowLength - 1) return true
        }

        // Right + diagonals unless at end of row
        if (this.index % rowLength != (rowLength - 1)) {
            if (index == this.index - rowLength + 1) return true
            if (index == this.index + 1) return true
            if (index == this.index + rowLength + 1) return true
        }

        // Up and down
        if (index == this.index - rowLength) return true
        if (index == this.index + rowLength) return true

        return false
    }

    private fun becameAlive(index: Int) {
        if (this.index == index) {
            alive = true
        } else if (isNeighbour(index)) {
            neighbours += 1
        }
    }
}

enum class MessageType {
    ALIVE,
    GENERATION
}

data class Message(val type: MessageType, val index: Int)

//fun main(args: Array<String>) {
//    val grid = Grid(3)
//
//    grid.seed(3)
//    grid.dispatchMessages()
//
//    grid.simulateGeneration()
//    println(grid)
//}