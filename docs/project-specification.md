# Project Specification

## Model Detective: From AI Weights to ARM Instructions

**Version:** 1.0  
**Status:** In development  
**Project type:** Software-only learning and experimentation project

## 1. Context

Machine learning models are commonly trained using high-level languages and libraries. However, the process of translating a trained model into low-level code and processor instructions is often less familiar to beginners.

Model Detective explores this process using a small machine learning model, a C implementation of its inference calculations, and a compiler targeting an ARM architecture.

The project is designed to run on a Windows computer without requiring physical hardware.

## 2. Objectives

The main objectives are to:

- Understand the mathematical operations and learned parameters of a small machine learning model.
- Implement the model's inference calculations in C.
- Compare Python and C predictions.
- Cross-compile the C program for a selected ARM target.
- Inspect the generated ARM assembly.
- Compare different compiler optimization settings.
- Document results through reproducible experiments.

## 3. Functional Requirements

### FR1: Model Training

- Generate or select a small dataset for binary classification.
- Train a simple model in Python, such as logistic regression.
- Extract its weights, bias, and other parameters needed for inference.
- Record the model configuration and reference predictions.

### FR2: C Implementation

- Implement the model's inference calculations in C.
- Load or define the exported model parameters.
- Accept the same input values as the Python implementation.
- Return a prediction score and predicted class.
- Keep the inference code independent of Python at runtime.

### FR3: Validation

- Evaluate Python and C implementations using identical inputs.
- Compare their prediction scores within a defined numerical tolerance.
- Check whether both implementations predict the same classes.
- Document any numerical differences.

### FR4: ARM Cross-Compilation

- Configure a suitable ARM cross-compiler.
- Select and document the target architecture.
- Compile the C implementation for the selected target.
- Generate an assembly listing.
- Identify relevant arithmetic, comparison, and branching instructions.

### FR5: Compiler Optimization Analysis

- Compile the program with optimization disabled or minimized.
- Compile it again using a higher optimization level.
- Compare the generated assembly.
- Compare available code-size measurements.
- Explain significant differences observed.

### FR6: Documentation

- Document the source code and experimental workflow.
- Provide reproducible build and test commands.
- Record results and observations.
- Clearly distinguish compilation, emulation, and execution on physical hardware.

## 4. Technical Architecture

The project consists of six logical components:

1. **Python training:** trains the model and provides reference predictions.
2. **Parameter export:** makes the learned parameters available to the C implementation.
3. **C inference:** reproduces the model's calculations.
4. **Validation tests:** compare Python and C outputs.
5. **ARM toolchain:** generates target-specific code and assembly.
6. **Analysis and documentation:** records measurements and explains the findings.

### Workflow

```text
Dataset
   |
   v
Python model training
   |
   v
Export model parameters
   |
   v
C inference implementation
   |
   v
Python/C validation
   |
   v
ARM cross-compilation
   |
   v
Assembly inspection
   |
   v
Optimization comparison
```

## 5. Tools and Environment

| Tool | Purpose |
|---|---|
| Windows | Development environment |
| Visual Studio Code | Code editing and project management |
| Python | Model training and reference implementation |
| scikit-learn | Training a simple classifier |
| C compiler | Building and testing the C implementation |
| ARM cross-compiler | Compiling for an ARM target |
| objdump or equivalent | Inspecting generated assembly |
| Git and GitHub | Version control and documentation |

The specific compiler, target architecture, and optional emulator will be selected during implementation.

## 6. Constraints

- No physical hardware is required.
- The first model must remain small and understandable.
- The C implementation should be independently testable.
- The project must remain manageable for a beginner.
- Experiments should be reproducible.
- Performance improvements must not be claimed without measurements.
- Emulated results must not be presented as measurements on physical hardware.

## 7. Evaluation Metrics

The project will investigate the following metrics where applicable:

- **Numerical error:** difference between Python and C prediction scores.
- **Prediction agreement:** percentage of inputs receiving the same predicted class.
- **Code size:** size of relevant generated artifacts.
- **Assembly differences:** changes in instructions and code structure across optimization settings.
- **Execution time:** optional measurements under documented conditions.
- **Reproducibility:** ability to rebuild the program and rerun the tests.

## 8. Acceptance Criteria

The initial project will be considered complete when:

- A small model has been trained and its parameters documented.
- C inference produces results consistent with the Python reference within a defined tolerance.
- Automated comparison tests pass.
- The C program has been compiled for a documented ARM target.
- ARM assembly has been generated and inspected.
- At least two compiler optimization configurations have been compared.
- The findings and limitations are documented in the repository.

## 9. Deliverables

- Python training script.
- Exported model parameters.
- C inference implementation.
- Automated validation tests.
- ARM cross-compilation commands or scripts.
- Relevant assembly listings or selected excerpts.
- Experimental results and comparisons.
- Updated README and technical documentation.

## 10. Project Phases

### Phase 1: Model Understanding
Train a simple classifier and inspect its parameters.

### Phase 2: C Implementation
Reproduce the model's inference calculations and validate the outputs.

### Phase 3: ARM Compilation
Configure the cross-compiler and generate ARM assembly.

### Phase 4: Assembly Investigation
Compare optimization settings and document the differences.

### Phase 5: Final Documentation
Consolidate tests, measurements, instructions, and conclusions.

## 11. Expected Outcome

The final result will be a compact, reproducible software project demonstrating the path from a trained machine learning model to a C implementation and ARM assembly.

Its main value will be the understanding and evidence gained from the experiments, rather than the complexity of the model.
