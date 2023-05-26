let mut list = LL::new("ACD");
list.insert(1, 'B');

let reference = &list;
reference.append('E'); // error

