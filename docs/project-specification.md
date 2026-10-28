# Project Specification

## Model Detective: From AI Weights to ARM Instructions

**Version:** 1.2  
**Status:** Implemented project scope  
**Project type:** Software-only learning and experimentation project

## 1. Context

Machine learning models are commonly trained using high-level languages and libraries. However, the process of translating a trained model into low-level code and processor instructions is often less familiar to beginners.

Model Detective explores this process using a small machine learning model, a C implementation of its inference calculations, and compiler toolchains targeting x86-64 and ARM64 architectures.

The project was developed on Windows and uses cross-compilation and emulation to investigate ARM64 execution without requiring physical ARM hardware.

## 2. Objectives

The project addresses the following objectives:

- Understand the mathematical operations and learned parameters of a small machine learning model.
- Implement the model's inference calculations in C.
- Compare Python and C predictions using reproducible tests.
- Generate x86-64 and ARM64 assembly.
- Cross-compile the C program for AArch64 Linux.
- Execute the ARM64 binary under QEMU user-mode emulation.
- Examine compiler optimization settings and generated assembly.
- Document experimental results, limitations, and reproducible procedures.

## 3. Functional Requirements

### FR1: Model Training

- Generate a small synthetic dataset for binary classification.
- Train a logistic regression model in Python using scikit-learn.
- Export the learned weights, bias, test input, and reference results.
- Record the model configuration and evaluation metrics.

**Implementation status:** Implemented.

The training script generates 300 samples with two input features and uses an 80/20 train/test split with a fixed random seed. It exports the learned parameters, the default reference prediction, and Python reference results for all 60 held-out test samples.

### FR2: C Implementation

- Implement the model's inference calculations in C.
- Read the exported model parameters.
- Calculate the linear score, sigmoid probability, and predicted class.
- Support inference using the default reference input and custom command-line inputs.
- Keep the inference calculations independent of Python at runtime.

**Implementation status:** Implemented.

The C program reads the exported parameters and calculates predictions using the same mathematical operations as the Python reference. Custom feature values can be supplied through command-line arguments.

### FR3: Validation

- Evaluate Python and C implementations using identical inputs.
- Compare prediction scores within a defined numerical tolerance.
- Verify that both implementations predict the same class.
- Validate held-out test samples and additional edge inputs.

**Implementation status:** Implemented and tested.

The automated Python `unittest` suite validates 66 inputs:

- 60 held-out test samples with exported Python reference results.
- 6 additional edge inputs, including zero-valued inputs, positive and negative values, and a decision-boundary case.

The tests compare numerical results using a tolerance of \(10^{-9}\) and verify predicted-class agreement.

The latest recorded test run passed both test methods. This validates consistency between the implementations for the tested inputs; it does not establish correctness for every possible input or generalization to real-world data.

### FR4: Cross-Compilation and Assembly Generation

- Generate x86-64 and AArch64 assembly.
- Compile the C program for AArch64 Linux.
- Inspect relevant arithmetic and floating-point instructions.
- Distinguish cross-compilation and emulation from execution on physical hardware.

**Implementation status:** Implemented.

Assembly listings are available at `-O0` and `-O2` for both architectures. The ARM64 executable has been cross-compiled and successfully executed under QEMU user-mode emulation.

### FR5: Compiler Optimization Analysis

- Generate assembly with optimization disabled and at a higher optimization level.
- Examine differences in instruction selection and code structure.
- Avoid unsupported performance conclusions based solely on assembly appearance.

**Implementation status:** Assembly generation and initial inspection completed.

The optimized AArch64 listing includes instructions such as `fmadd`, which performs a fused multiply-add operation. This is an observation about generated code, not proof of improved execution speed or energy efficiency.

### FR6: Documentation and Reproducibility

- Document the source code and experimental workflow.
- Provide build, execution, and test commands.
- Record reference results and compiler configurations.
- Distinguish cross-compilation, emulation, and physical-device measurements.
- State the limitations of the experiments.

**Implementation status:** Documented.

The repository includes the model-training script, C inference implementation, automated tests, exported results, assembly listings, build instructions, and project documentation.

## 4. Technical Architecture

The project consists of six logical components:

1. **Python training:** Generates the synthetic dataset and trains the classifier.
2. **Parameter export:** Saves learned parameters and reference prediction results.
3. **C inference:** Calculates the linear score, probability, and predicted class.
4. **Validation tests:** Compare C results against Python reference calculations.
5. **Compiler toolchains:** Generate x86-64 and AArch64 code and assembly.
6. **Analysis and documentation:** Records the observed instruction differences, results, and limitations.

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
 Validate Python and C across 66 inputs
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
 Examine generated assembly
```

## 5. Tools and Environment

| Tool | Purpose |
|---|---|
| Windows | Development environment |
| Visual Studio Code | Code editing and project management |
| Python | Model training and reference implementation |
| scikit-learn | Training the logistic regression classifier |
| NumPy | Numerical calculations |
| C | Implementing model inference |
| GCC | Native compilation and x86-64 assembly generation |
| Arm GNU Toolchain | AArch64 Linux cross-compilation and assembly generation |
| QEMU user-mode emulation | Executing the ARM64 binary on a non-ARM host |
| Python `unittest` | Automated validation |
| Git and GitHub | Version control and documentation |

The recorded native compiler is GCC 13.2.0 targeting `x86_64-w64-mingw32`. The recorded Arm GNU Toolchain version is 15.3.1, targeting `aarch64-none-linux-gnu`.

Compiler installation paths are environment-specific and may need adjustment when reproducing the experiments on another machine.

## 6. Constraints and Assumptions

- No physical ARM hardware is required for the documented emulation experiments.
- The model is deliberately small and intended to make its calculations understandable.
- C inference is independently executable at runtime.
- The dataset is synthetic and intended for learning rather than real-world model evaluation.
- The training and test split uses a fixed random seed.
- Numerical comparisons use a stated tolerance.
- Performance improvements are not claimed without appropriate measurements.
- QEMU results are not presented as measurements on physical hardware.
- Agreement on the tested inputs does not establish correctness for all possible inputs.

## 7. Evaluation Metrics and Results

The project records or examines the following metrics:

- **Training and test accuracy:** Classification results on the generated dataset.
- **Numerical error:** Difference between Python and C inference results.
- **Prediction agreement:** Whether both implementations predict the same class.
- **Assembly differences:** Instruction selection and code structure across architectures and optimization settings.
- **Reproducibility:** Ability to rebuild the program and rerun the automated tests.

The current model reports:

| Metric | Result |
|---|---:|
| Training accuracy | 98.33% |
| Test accuracy | 100.00% |
| Held-out samples tested against C | 60 |
| Additional edge inputs tested | 6 |
| Total tested inputs | 66 |
| Numerical comparison tolerance | \(10^{-9}\) |

The accuracy figures come from one fixed split of a synthetic dataset and should not be interpreted as evidence of real-world generalization.

The C and Python implementations passed the recorded automated validation tests for the tested inputs.

## 8. Acceptance Criteria

The implemented project scope is considered complete based on the following results:

- A logistic regression model has been trained and its parameters exported.
- C inference calculates the linear score, sigmoid probability, and predicted class.
- Custom command-line inputs are supported by the C executable.
- Automated tests compare Python and C results across 60 held-out samples and 6 additional edge inputs.
- x86-64 and AArch64 assembly listings have been generated at `-O0` and `-O2`.
- The C program has been cross-compiled for the documented AArch64 Linux target.
- The ARM64 binary has been executed successfully under QEMU.
- The repository documents the workflow, observed results, and experimental limitations.

## 9. Deliverables

The repository contains:

- Python model-training script.
- Exported model parameters and reference results.
- C inference implementation.
- Automated Python/C validation tests.
- x86-64 assembly listings at `-O0` and `-O2`.
- AArch64 assembly listings at `-O0` and `-O2`.
- ARM64 build and QEMU execution instructions.
- Project README and technical documentation.
- Documented experimental observations and limitations.

The cross-compiled executable may be generated locally and excluded from version control, depending on the repository configuration.

## 10. Project Phases

### Phase 1: Model Understanding

A logistic regression classifier was trained on a synthetic dataset, and its learned parameters were exported.

**Status:** Completed.

### Phase 2: C Implementation and Validation

The inference calculations were implemented in C and validated against Python reference results across 66 inputs.

**Status:** Completed.

### Phase 3: Cross-Compilation and Assembly Generation

Compiler toolchains were used to generate x86-64 and AArch64 assembly at two optimization levels.

**Status:** Completed.

### Phase 4: ARM64 Emulation

The cross-compiled AArch64 Linux executable was successfully executed using QEMU user-mode emulation.

**Status:** Completed.

### Phase 5: Assembly Inspection and Documentation

Generated assembly was inspected for relevant instruction differences, and the experimental workflow and limitations were documented.

**Status:** Completed for the scope of this project.

## 11. Expected Outcome

Model Detective demonstrates a reproducible path from a trained machine learning model to a C inference implementation, architecture-specific assembly, and ARM64 execution under emulation.

Its primary value is the practical understanding gained by connecting high-level model training with low-level computation and compiler-generated instructions.

The project provides a documented example of cross-implementation numerical validation, cross-compilation, assembly inspection, and emulated execution, while clearly distinguishing demonstrated results from claims that would require additional evidence.

## 12. License

See the repository's `LICENSE` file.
