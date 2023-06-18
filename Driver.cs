using System;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Grover {
    class Driver {
        static void Main(string[] args) {
            using (var sim = new QuantumSimulator()) {
                var result = RunGrover.Run(sim).Result;
                Console.WriteLine($"Search result: {result}");
            }
        }
    }
}