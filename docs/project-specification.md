# Project Specification

## Model Detective: From AI Weights to ARM Instructions

**Version:** 1.1  
**Status:** Core pipeline implemented; analysis and documentation ongoing  
**Project type:** Software-only learning and experimentation project

## 1. Context

Machine learning models are commonly trained using high-level languages and libraries. However, the process of translating a trained model into low-level code and processor instructions is often less familiar to beginners.

Model Detective explores this process using a small machine learning model, a C implementation of its inference calculations, and compiler toolchains targeting x86-64 and ARM64 architectures.

The project is developed on Windows and uses cross-compilation and emulation to investigate ARM64 execution without requiring physical ARM hardware.

## 2. Objectives

The main objectives are to:

- Understand the mathematical operations and learned parameters of a small machine learning model.
- Implement the model's inference calculations in C.
- Compare Python and C predictions using reproducible tests.
- Generate x86-64 and ARM64 assembly.
- Cross-compile the C program for AArch64 Linux.
- Execute the ARM64 binary under QEMU user-mode emulation.
- Compare compiler optimization settings and generated assembly.
- Document results, limitations, and reproducible experiments.

## 3. Functional Requirements

### FR1: Model Training

- Generate a small synthetic dataset for binary classification.
- Train a logistic regression model in Python using scikit-learn.
- Export the learned weights, bias, test input, and reference results.
- Record the model configuration and evaluation metrics.

**Implementation status:** Implemented.

The current training script generates 300 samples with two input features and uses an 80/20 train/test split with a fixed random seed.

### FR2: C Implementation

- Implement the model's inference calculations in C.
- Read the exported model parameters.
- Calculate the linear score, sigmoid probability, and predicted class.
- Keep the inference calculations independent of Python at runtime.

**Implementation status:** Implemented.

The C program reads the exported parameters and calculates the prediction using the same reference input as the Python implementation.

### FR3: Validation

- Evaluate Python and C implementations using identical inputs.
- Compare prediction scores within a defined numerical tolerance.
- Verify that both implementations predict the same class.
- Document numerical differences and test limitations.

**Implementation status:** Implemented for the current reference input.

An automated Python `unittest` test compares the C output with the exported Python reference. The test uses a numerical tolerance of \(10^{-9}\) and checks the predicted class.

Broader testing across multiple inputs and edge cases remains future work.

### FR4: Cross-Compilation and Assembly Generation

- Configure and document the relevant compiler toolchains.
- Generate x86-64 and AArch64 assembly.
- Compile the C implementation for AArch64 Linux.
- Identify relevant arithmetic, comparison, and branching instructions.
- Distinguish cross-compilation from execution on physical hardware.

**Implementation status:** Compilation and assembly generation implemented.

Assembly listings are generated at `-O0` and `-O2` for both architectures. The ARM64 executable has also been successfully cross-compiled and executed under QEMU user-mode emulation.

### FR5: Compiler Optimization Analysis

- Generate assembly with optimization disabled and with a higher optimization level.
- Compare the resulting instruction sequences.
- Identify relevant changes in arithmetic and instruction selection.
- Investigate code size and execution performance when reliable measurements are available.
- Avoid unsupported performance conclusions based solely on assembly appearance.

**Implementation status:** Initial assembly generation and inspection completed; deeper analysis remains ongoing.

The optimized AArch64 listing includes instructions such as `fmadd`, which performs a fused multiply-add operation. Its presence is an observation about generated code, not proof of a performance improvement.

### FR6: Documentation and Reproducibility

- Document the source code and experimental workflow.
- Provide build, execution, and test commands.
- Record reference results and compiler configurations.
- Distinguish native execution, cross-compilation, emulation, and physical-device measurements.
- Clearly state the limitations of the experiments.

**Implementation status:** Core documentation exists and is being refined.

## 4. Technical Architecture

The project consists of six logical components:

1. **Python training:** Generates the synthetic dataset and trains the classifier.
2. **Parameter export:** Saves the learned parameters and reference prediction results.
3. **C inference:** Calculates the linear score, probability, and predicted class.
4. **Validation tests:** Compare C results against the Python reference.
5. **Compiler toolchains:** Generate x86-64 and AArch64 code and assembly.
6. **Analysis and documentation:** Records results, explains instruction differences, and documents limitations.

### Workflow

```text
Synthetic classification dataset
             |
             v
     Python model training
             |
             v
 Export parameters and reference results
             |
             v
      C inference implementation
             |
             v
       Python/C validation
             |
             v
 Generate x86-64 and ARM64 assembly
             |
             v
 Cross-compile ARM64 Linux executable
             |
             v
       Execute using QEMU
             |
             v
 Analyze assembly and optimizations
```

## 5. Tools and Environment

| Tool | Purpose |
|---|---|
| Windows | Development environment |
| Visual Studio Code | Code editing and project management |
| Python | Model training and reference implementation |
| scikit-learn | Training the logistic regression classifier |
| C | Implementing model inference |
| GCC | Native compilation and x86-64 assembly generation |
| Arm GNU Toolchain | AArch64 Linux cross-compilation and assembly generation |
| QEMU user-mode emulation | Executing the ARM64 binary on a non-ARM host |
| Python `unittest` | Automated validation |
| Git and GitHub | Version control and documentation |

The recorded native compiler is GCC 13.2.0 targeting `x86_64-w64-mingw32`. The recorded Arm GNU Toolchain version is 15.3.1, targeting `aarch64-none-linux-gnu`.

The exact compiler installation paths are environment-specific and should be adjusted when reproducing the experiments on another machine.

## 6. Constraints and Assumptions

- No physical ARM hardware is required for the initial experiments.
- The model must remain small and understandable.
- The C inference calculations must be independently executable.
- The dataset is synthetic and is intended for learning, not real-world model evaluation.
- Experiments should be reproducible using documented configurations and commands.
- Numerical comparisons must use a stated tolerance.
- Performance improvements must not be claimed without appropriate measurements.
- QEMU results must not be presented as measurements on physical hardware.
- Results from a single reference input do not establish correctness for all possible inputs.

## 7. Evaluation Metrics

The project investigates the following metrics where applicable:

- **Training and test accuracy:** Classification performance on the generated dataset.
- **Numerical error:** Difference between Python and C prediction scores.
- **Prediction agreement:** Whether both implementations predict the same class.
- **Assembly differences:** Changes in instruction selection and code structure across architectures and optimization settings.
- **Code size:** Size of relevant executables or generated artifacts when measured consistently.
- **Execution time:** Optional measurements under documented conditions.
- **Reproducibility:** Ability to rebuild the program and rerun the tests.

The current model reports 98.33% training accuracy and 100.00% test accuracy on one fixed synthetic-data split. These figures should not be interpreted as evidence of real-world generalization.

## 8. Acceptance Criteria

The initial implementation milestone is considered achieved when:

- A small model has been trained and its parameters exported.
- C inference produces results consistent with the Python reference within a defined tolerance.
- The automated comparison test passes for the current reference input.
- x86-64 and AArch64 assembly listings have been generated at two optimization levels.
- The C program has been cross-compiled for the documented AArch64 Linux target.
- The ARM64 binary has been executed successfully under QEMU.
- Initial assembly differences and experimental limitations are documented.

The broader investigation will be strengthened by testing additional inputs, analyzing further instruction-level differences, and performing appropriate benchmarks on suitable hardware.

## 9. Deliverables

- Python model-training script.
- Exported model parameters and reference results.
- C inference implementation.
- Automated validation test.
- x86-64 assembly listings at `-O0` and `-O2`.
- AArch64 assembly listings at `-O0` and `-O2`.
- Cross-compiled ARM64 Linux executable, generated locally and excluded from version control where configured.
- ARM64 build and QEMU execution instructions.
- Project README and technical documentation.
- Documented observations, limitations, and future experiments.

## 10. Project Phases

### Phase 1: Model Understanding

Train a simple classifier and inspect its learned parameters.

**Status:** Completed.

### Phase 2: C Implementation and Validation

Reproduce the model's inference calculations and compare the results with the Python reference.

**Status:** Implemented for the current reference input.

### Phase 3: Cross-Compilation

Configure the compiler toolchains and generate architecture-specific assembly.

**Status:** Completed for the documented x86-64 and AArch64 configurations.

### Phase 4: ARM64 Emulation

Execute the cross-compiled AArch64 Linux binary using QEMU user-mode emulation.

**Status:** Completed for the current reference input.

### Phase 5: Assembly Investigation

Compare optimization settings and document instruction-level differences.

**Status:** Initial inspection completed; further analysis remains ongoing.

### Phase 6: Expanded Validation and Benchmarking

Test additional inputs and edge cases. Investigate code size, execution time, and other performance metrics when appropriate hardware and measurement methods are available.

**Status:** Planned.

## 11. Expected Outcome

The project demonstrates a reproducible path from a trained machine learning model to a C inference implementation, architecture-specific assembly, and ARM64 execution under emulation.

Its primary value is the understanding and evidence gained from the experiments, rather than the complexity of the model.

The project also establishes a foundation for future work on numerical consistency, compiler optimization, instruction-level analysis, and hardware-aware inference.
