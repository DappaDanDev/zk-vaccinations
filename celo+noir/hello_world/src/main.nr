use dep::std;

fn main(x: Field, y: pub Field) -> pub Field {
    assert(x != y);
    let hash = std::hash::pedersen_hash([x, y]);

    hash
}
