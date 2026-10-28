# Model Detective 🔎

**From AI Weights to ARM Instructions**

Model Detective is a hands-on project exploring how a machine learning model moves from trained parameters to C inference code and processor instructions.

The project connects machine learning, numerical computation, compiler optimization, and ARM64 assembly through a small, reproducible classification example.

## Project Status

The core inference pipeline has been implemented. Current work focuses on improving documentation, making experiments reproducible, and deepening the analysis of generated assembly.

## Objectives

- Train a small machine learning model in Python.
- Extract its learned parameters and implement inference in C.
- Validate that Python and C produce consistent predictions.
- Generate x86-64 and ARM64 assembly using GCC-compatible toolchains.
- Compare assembly generated at different optimization levels.
- Execute a cross-compiled ARM64 binary under emulation.
- Establish a reproducible foundation for future performance measurements.

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
      Compare Python and C results
              |
              v
 Generate x86-64 and ARM64 assembly
              |
              v
 Execute ARM64 binary using QEMU
              |
              v
 Analyze instructions and optimizations
```

## Technologies

| Technology | Purpose |
|---|---|
| Python | Train the model and generate reference results |
| scikit-learn | Train a logistic regression classifier |
| C | Implement the model's inference calculations |
| GCC | Compile the C program and generate assembly |
| AArch64 cross-compiler | Generate ARM64 Linux code |
| QEMU user-mode emulation | Execute the ARM64 binary on a non-ARM host |
| Python `unittest` | Validate consistency between implementations |
| Git and GitHub | Version control and project documentation |

## Implemented Components

### 1. Model Training and Parameter Export

The Python training script generates a synthetic binary classification dataset and trains a logistic regression model.

The current configuration uses:

- 300 generated samples.
- Two input features.
- An 80/20 training and test split.
- A fixed random seed for reproducibility.

The script exports the learned weights, bias, test input, and reference results for use by the C implementation.

### 2. C Inference

The C implementation loads the exported parameters and calculates:

- The linear score.
- The sigmoid probability.
- The predicted binary class.

This demonstrates how trained model parameters can be used to perform inference without running the original scikit-learn model.

### 3. Python and C Validation

The project includes an automated test that compares C inference results against the Python reference.

The test checks numerical agreement within a defined tolerance and verifies that the predicted class matches.

### 4. Assembly Generation

Assembly is generated for two architectures at two optimization levels.

| Architecture | Optimization | Output |
|---|---|---|
| x86-64 | `-O0` | `results/inference_O0.s` |
| x86-64 | `-O2` | `results/inference_O2.s` |
| ARM64 / AArch64 | `-O0` | `results/inference_ARM_O0.s` |
| ARM64 / AArch64 | `-O2` | `results/inference_ARM_O2.s` |

The compiler's `-S` option generates assembly without linking an executable.

The ARM64 listings contain floating-point instructions such as `fmul` and `fadd`. The optimized version also includes `fmadd`, a fused multiply-add instruction.

These instructions provide a starting point for studying compiler optimization. Their presence alone does not establish that one version is faster or more energy-efficient.

### 5. ARM64 Execution Under Emulation

The C program has been cross-compiled into a Linux AArch64 executable and successfully executed using QEMU user-mode emulation.

For the current reference input, the program reports:

| Output | Value |
|---|---:|
| Linear score | `-3.788110560018` |
| Probability | `0.022137186201` |
| Predicted class | `0` |

The emulated ARM64 program reproduces the expected output for this input at the displayed precision.

**Important limitation:** QEMU execution demonstrates that the ARM64 binary can run under emulation. It does not measure native ARM hardware performance, energy consumption, or real-time behavior.

## Current Model Results

The current training run reports:

| Metric | Result |
|---|---:|
| Training accuracy | 98.33% |
| Test accuracy | 100.00% |

These results come from a small synthetic dataset and one fixed train/test split. They demonstrate the current pipeline, not generalization to real-world data.

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

Generated binaries and other ignored files may not appear in the repository. Refer to the actual checkout if the directory structure changes.

## Reproducing the Experiments

The following commands assume Windows PowerShell, an existing Python virtual environment, and the required compilers installed.

### 1. Train the Model

```powershell
.\.venv\Scripts\python.exe python\train_model.py
```

This regenerates the exported parameters and reference results.

### 2. Compile and Run C Inference

Using GCC:

```powershell
gcc c\inference.c -o c\inference.exe -lm
.\c\inference.exe
```

### 3. Run the Prediction Test

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

Cross-compilation requires the target Linux sysroot provided by the installed toolchain. See [ARM64 Inference Validation](arm/README.md) for the complete build and QEMU execution procedure.

## Limitations

- The classifier uses synthetic rather than real-world data.
- The reported test accuracy is based on one fixed split.
- Current numerical validation uses a fixed reference input; broader input coverage would strengthen confidence.
- ARM64 execution has been verified under emulation, not on physical ARM hardware.
- No reliable native latency, throughput, or energy measurements have been established.
- Assembly differences must be interpreted in context; instruction counts alone are not performance benchmarks.

## Roadmap

- [x] Define the initial project specification.
- [x] Train a model and export its parameters.
- [x] Implement inference in C.
- [x] Validate Python and C predictions.
- [x] Generate x86-64 assembly at `-O0` and `-O2`.
- [x] Generate ARM64 assembly at `-O0` and `-O2`.
- [x] Cross-compile the ARM64 executable.
- [x] Execute the ARM64 binary under QEMU.
- [ ] Expand numerical tests across multiple inputs and edge cases.
- [ ] Document instruction-level differences with exact assembly excerpts.
- [ ] Establish reproducible benchmarking on suitable hardware.
- [ ] Compare code size and execution performance using appropriate measurements.

## Learning Goals

This project aims to develop practical understanding of:

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
