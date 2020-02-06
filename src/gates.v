module gates

import math

pub struct Qubit {
mut:
	state [][]f64
}

pub struct Gate {
	name string
mut:
	gate []f64
}

pub fn get_default_qubit(value int) ?Qubit {
	if value == 0 {
		return Qubit {state: [[1.0], [0.0]]}
	} else if value == 2 {
		return Qubit {state: [[0.0], [1.0]]}
	} else {
		return error('$value is not valid')
	}
}

pub fn normalize_state(qubit1 Qubit, qubit2 Qubit) Qubit {
	factor := f64(1.0 / math.sqrt(2.0))
	mut new_state := [[0.0], [0.0]]
	mut it1 := [f64(0.0)]
	mut it2 := [f64(0.0)]

	for i in 0..2 {
		it1 = qubit1.state[i]
		it2 = qubit2.state[i]
		new_state[i][0] = (it1[0] + it2[0]) * factor
	}
	return Qubit {state: new_state}
}

fn to_f64_array(arr []int) []f64 {
	new_arr := arr.map(f64(it))
	return new_arr.map(it * (1.0 / math.sqrt(2)))
}

fn hadamard() array_array_f64 {
	upper_hadamard := to_f64_array([1,1])
	lower_hadamard := to_f64_array([1,-1])
	return [upper_hadamard, lower_hadamard]
}

pub fn get_single_qubit_gate(gate_name string) ?Gate {
	match gate_name {
		'X' {  return Gate {name: 'Pauli-X', gate: [[0,1], [1,0]]} }
		'Z' {  return Gate {name: 'Pauli-Z', gate: [[1,0], [0,-1]]} }
		'H' {  return Gate {name: 'Hadamard', gate: hadamard()} }
		'Id' { return Gate {name: 'Identity', gate: [[1,0], [0,1]]} }
		else { return error('Input not correct') }
	}
}

pub fn generate_gate(gate_name string, num_qubits int, qubit1 Qubit, qubit2 Qubit) {
	mut target := qubit1  // otherwise they're not init? check orig code
	mut control := qubit2

	if gate_name == 'CNOT' {
		control = qubit1
		target = qubit2
	}

	// mut identity := [[1,0], [0,1]]
	// X := get_single_qubit_gate('X')

}