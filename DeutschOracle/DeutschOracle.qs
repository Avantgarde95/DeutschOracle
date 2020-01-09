namespace Quantum.DeutschOracle {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation Clear(a: Qubit, b: Qubit): Unit {
        body {
            Reset(a);
            Reset(b);
        }
    }

    operation IsBlackBoxConstant(blackBox: ((Qubit, Qubit) => Unit)) : (Bool) {
        body {
            mutable inputResult = Zero;
            mutable outputResult = Zero;

            // Allocate two qbits.
            using (qbits = Qubit[2]) {
                let input = qbits[0];
                let output = qbits[1];

                // Label qbits as inputs and outputs.
                Clear(input, output);

                // Pre-processing.
                X(input);
                X(output);
                H(input);
                H(output);

                // Send qbits into black box.
                blackBox(input, output);

                // Post-processing.
                H(input);
                H(output);

                // Measure both qbits.
                set inputResult = M(input);
                set outputResult = M(output);

                // Clear qbits before release.
                Clear(input, output);
            }

            return One == inputResult;
        }
    }

    operation IsConstantZeroConstant(): (Bool) {
        body {
            return IsBlackBoxConstant(ConstantZero);
        }
    }

    operation IsConstantOneConstant(): (Bool) {
        body {
            return IsBlackBoxConstant(ConstantOne);
        }
    }

    operation IsIdentityConstant(): (Bool) {
        body {
            return IsBlackBoxConstant(Identity);
        }
    }

    operation IsNegationConstant(): (Bool) {
        body {
            return IsBlackBoxConstant(Negation);
        }
    }
}

