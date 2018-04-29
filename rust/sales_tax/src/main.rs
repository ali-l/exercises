#[derive(Debug)]
pub struct Item {
    quantity: i32,
    name: String,
    price: i32,
    tax: i32
}

impl Item {
    fn tax(&self) -> i32 {
        self.tax * self.quantity
    }

    fn price(&self) -> i32 {
        self.price * self.quantity
    }
}

#[derive(Debug)]
pub struct Receipt {
    items: Vec<Item>,
    total_tax: i32,
    total_price: i32
}

impl Receipt {
    fn new() -> Receipt {
        Receipt {
            items: vec![],
            total_tax: 0,
            total_price: 0
        }
    }

    fn add_item(&mut self, item: Item) {
        self.total_tax += item.tax();
        self.total_price += item.price();
        self.items.push(item);
    }
}

fn main() {
    let mut r = Receipt::new();

    let items = vec![
        Item {
            quantity: 2,
            name: String::from("chocolate bar"),
            price: 110,
            tax: 1
        },
        Item {
            quantity: 1,
            name: String::from("pills"),
            price: 10,
            tax: 10
        }
    ];

    for item in items.into_iter() {
        r.add_item(item);
    }

    println!("#{:?}", r);
}