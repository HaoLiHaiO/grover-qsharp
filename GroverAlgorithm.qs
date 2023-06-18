namespace Quantum.Grover {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;

    // Apply oracle
    // For simplicity, I consider the third item as marked.
    operation MarkedItemOracle(qubits : Qubit[]) : Unit is Adj {
        // Flip the sign of the state that represents the marked item.
        Z(qubits[1]);
    }

    // This operation applies the Grover diffusion operator.
    operation ReflectAboutAverage(qubits : Qubit[]) : Unit is Adj {
        within {
            // Apply Hadamard
            ApplyToEachA(H, qubits);
            // Apply Pauli-X
            ApplyToEachA(X, qubits);
        } apply {
            // Entangle the qubits and flip the sign of the |-⟩ state.
            Controlled Z(Most(qubits), Tail(qubits));
        }
    }

    // This operation implements Grover's algorithm.
    operation RunGrover() : Result[] {
        mutable resultArray = new Result[2];
        using (qubits = Qubit[2]) {
            // Start in equal superposition over all items.
            ApplyToEach(H, qubits);
            // Repeat the following process twice.
            for (_ in 0..1) {
                // Apply the oracle to mark the item.
                MarkedItemOracle(qubits);
                // Apply the Grover diffusion operator.
                ReflectAboutAverage(qubits);
            }
            // Measure the result.
            set resultArray = MultiM(qubits);
            ResetAll(qubits);
        }
        return resultArray;
    }
}
