# Model Detective 🔎

**From AI Weights to ARM Instructions**

Model Detective is a hands-on project exploring how a machine learning model moves from trained parameters to C inference code and processor instructions.

The project connects machine learning, numerical computation, compiler optimization, and ARM64 assembly through a reproducible classification example.

## Project Overview

The project implements an end-to-end workflow covering:

- Training a logistic regression classifier in Python.
- Exporting learned parameters and reference predictions.
- Implementing model inference in C.
- Validating Python and C numerical consistency across multiple inputs.
- Generating x86-64 and ARM64 assembly at different optimization levels.
- Cross-compiling and executing an ARM64 binary under QEMU emulation.

## How It Works

```text
Synthetic classification dataset
             |
             v
      Train model in Python
             |
             v
 Export parameters and reference results
             |
             v
       Implement inference in C
             |
             v
 Compare Python and C across 66 inputs
             |
             v
 Generate x86-64 and ARM64 assembly
             |
             v
 Execute ARM64 binary using QEMU
             |
             v
 Examine generated instructions
```

## Technologies

| Technology | Purpose |
|---|---|
| Python | Model training and reference calculations |
| scikit-learn | Logistic regression classifier |
| NumPy | Numerical calculations |
| C | Model inference implementation |
| GCC | Compilation and assembly generation |
| AArch64 cross-compiler | ARM64 Linux cross-compilation |
| QEMU | ARM64 user-mode emulation |
| Python `unittest` | Automated validation |
| Git and GitHub | Version control and project hosting |

## Implemented Components

### 1. Model Training and Parameter Export

The Python training script generates a synthetic binary classification dataset and trains a logistic regression model.

Configuration:

- 300 generated samples.
- Two input features.
- 80/20 training and test split.
- Fixed random seed for reproducibility.

The script exports the learned weights, bias, reference prediction, and results for all held-out test samples.

### 2. C Inference

The C implementation loads the exported model parameters and computes:

- Linear score.
- Sigmoid probability.
- Predicted binary class.

The executable accepts custom input values through command-line arguments, allowing predictions to be evaluated without modifying the source code.

This demonstrates how trained model parameters can be used for inference without running the original scikit-learn model.

### 3. Python and C Validation

Automated tests compare C inference against Python reference calculations.

The test suite covers **66 inputs**:

- 60 held-out test samples.
- 6 additional edge inputs, including zero-valued inputs, positive and negative values, and a decision-boundary case.

The tests check numerical agreement within a tolerance of `1e-9` and verify that predicted classes match.

The latest test run completed successfully:

```text
test_all_held_out_test_samples ... ok
test_edge_inputs ... ok

Ran 2 tests
OK
```

These tests validate consistency between the two implementations; they do not establish real-world predictive performance.

### 4. Assembly Generation

Assembly listings are generated for x86-64 and ARM64 at two optimization levels.

| Architecture | Optimization | Output |
|---|---|---|
| x86-64 | `-O0` | `results/inference_O0.s` |
| x86-64 | `-O2` | `results/inference_O2.s` |
| ARM64 / AArch64 | `-O0` | `results/inference_ARM_O0.s` |
| ARM64 / AArch64 | `-O2` | `results/inference_ARM_O2.s` |

The compiler's `-S` option generates assembly without linking an executable.

The ARM64 listings contain floating-point instructions such as `fmul` and `fadd`. The optimized listing also includes `fmadd`, a fused multiply-add instruction.

These instructions illustrate how compiler optimization affects generated machine-level code. Their presence alone does not establish a performance advantage.

### 5. ARM64 Execution Under Emulation

The C program has been cross-compiled into a Linux AArch64 executable and successfully executed using QEMU user-mode emulation.

For the reference input, the program reports:

| Output | Value |
|---|---:|
| Linear score | `-3.788110560018` |
| Probability | `0.022137186201` |
| Predicted class | `0` |

The emulated ARM64 program reproduces the expected output for this input at the displayed precision.

QEMU execution demonstrates that the ARM64 binary can run under emulation. It does not measure native ARM hardware performance, energy consumption, or real-time behavior.

## Model Results

The current training run reports:

| Metric | Result |
|---|---:|
| Training accuracy | 98.33% |
| Test accuracy | 100.00% |

These results come from a synthetic dataset and one fixed train/test split. They demonstrate the implemented workflow rather than generalization to real-world data.

## Repository Structure

```text
model-detective/
├── README.md
├── LICENSE
├── .gitattributes
├── .gitignore
├── python/
│   └── train_model.py
├── c/
│   └── inference.c
├── tests/
│   └── test_predictions.py
├── docs/
│   ├── project-specification.md
│   └── assembly-comparison.md
├── arm/
│   └── README.md
└── results/
    ├── model_parameters.json
    ├── model_parameters.txt
    ├── inference_O0.s
    ├── inference_O2.s
    ├── inference_ARM_O0.s
    └── inference_ARM_O2.s
```

Generated binaries and other ignored files may not appear in the repository.

## Reproducing the Experiments

The following commands assume Windows PowerShell, an existing Python virtual environment, and the required compilers installed.

### 1. Train the Model

```powershell
.\.venv\Scripts\python.exe python\train_model.py
```

This regenerates the model parameters and Python reference results.

### 2. Compile and Run C Inference

```powershell
gcc c\inference.c -o c\inference.exe -lm
.\c\inference.exe
```

To evaluate custom input values:

```powershell
.\c\inference.exe 1.0 -1.0
```

### 3. Run the Automated Tests

```powershell
.\.venv\Scripts\python.exe -m unittest discover -s tests -v
```

### 4. Generate x86-64 Assembly

```powershell
gcc -S -O0 c\inference.c -o results\inference_O0.s
gcc -S -O2 c\inference.c -o results\inference_O2.s
```

### 5. Generate ARM64 Assembly

Use an installed AArch64 cross-compiler:

```powershell
$armgcc = "C:\Program Files\Arm\GNU Toolchain mingw-w64-x86_64-aarch64-none-linux-gnu\bin\aarch64-none-linux-gnu-gcc.exe"

& $armgcc -S -O0 c\inference.c -o results\inference_ARM_O0.s
& $armgcc -S -O2 c\inference.c -o results\inference_ARM_O2.s
```

The compiler path may need to be adjusted to match your installation.

### 6. Cross-Compile and Execute the ARM64 Binary

Cross-compilation requires the target Linux sysroot provided by the installed toolchain. See [ARM64 Inference Validation](arm/README.md) for the build and QEMU execution procedure.

## Limitations

- The classifier uses synthetic rather than real-world data.
- Reported accuracy is based on one fixed train/test split.
- Numerical agreement between implementations does not establish real-world predictive performance.
- ARM64 execution was verified under emulation rather than on physical ARM hardware.
- Native latency, throughput, and energy consumption have not been measured.
- Assembly differences alone do not establish execution speed or energy efficiency.

## Learning Outcomes

This project demonstrates practical experience with:

- Machine learning inference and learned parameters.
- Numerical consistency across implementations.
- C compilation and floating-point computation.
- Compiler optimization and generated assembly.
- x86-64 and ARM64 instruction sets.
- Cross-compilation, emulation, and reproducible experiments.

## Documentation

- [Project Specification](docs/project-specification.md)
- [Assembly Comparison](docs/assembly-comparison.md)
- [ARM64 Inference Validation](arm/README.md)

## License

See the [LICENSE](LICENSE) file.
