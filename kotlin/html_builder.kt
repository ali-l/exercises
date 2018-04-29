fun main(args: Array<String>) {
    println(html {
        body {
            div {
                div { "Hello" }
                span { "hi" }
            }
        }
    })
}

fun html(child: () -> String) : String {
    return "<!DOCTYPE html>\n<html lang=\"en\">\n${child()}\n</html>"
}

fun body(child: () -> String) : String {
    return "<body>\n${child()}\n</body>"
}

//fun div(child: () -> String) : String {
//    return "<div>\n${child()}\n</div>"
//}

val div = buildComponent("div")

val span = buildComponent("span")

fun buildComponent(tag: String) : (() -> String) -> String {
    return { child -> "<$tag>\n${child()}\n</$tag>" }
}