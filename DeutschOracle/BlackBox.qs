namespace Quantum.DeutschOracle {
	open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation ConstantZero(input: Qubit, output: Qubit) : Unit {
		body {
			// Do nothing.
		}
	}

    operation ConstantOne(input: Qubit, output: Qubit) : Unit {
		body {
			X(output);
		}
	}

	operation Identity(input: Qubit, output: Qubit) : Unit {
		body {
			CNOT(input, output);
		}
	}

	operation Negation(input: Qubit, output: Qubit) : Unit {
		body {
			CNOT(input, output);
			X(output);
		}
	}
}

