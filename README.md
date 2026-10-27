# Model Detective 🔎

**From AI Weights to ARM Instructions**

Model Detective is a hands-on learning project exploring how a small machine learning model moves from mathematical parameters to C code and, eventually, ARM assembly.

The goal is to understand not only how a model makes predictions, but also how those predictions are implemented and translated into processor instructions.

> 🚧 **Status: In development.** This repository will be updated progressively as each stage is implemented and tested.

## 🎯 Objectives

- Understand the weights and calculations of a small machine learning model.
- Implement model inference in C.
- Compare Python and C predictions.
- Cross-compile the C program for an ARM target.
- Inspect the generated assembly instructions.
- Compare compiler optimization levels and document the differences.

## 🧠 Planned Workflow

```text
Train a small model in Python
            |
            v
Inspect weights and calculations
            |
            v
Implement inference in C
            |
            v
Compare Python and C predictions
            |
            v
Compile for an ARM target
            |
            v
Inspect ARM assembly
            |
            v
Compare compiler optimizations
```

## 🛠️ Technologies

| Technology | Purpose |
|---|---|
| Python | Train the model and create a reference implementation |
| scikit-learn | Build a simple classification model |
| C | Reimplement the model's inference calculations |
| GCC | Compile and inspect generated code |
| ARM cross-compiler | Generate code for the selected ARM target |
| objdump | Inspect assembly instructions |
| Git and GitHub | Track progress and document experiments |

The exact toolchain will be selected during implementation.

## 📂 Planned Project Structure

```text
model-detective/
├── README.md
├── LICENSE
├── docs/
│   └── project-specification.md
├── python/
│   └── train_model.py
├── c/
│   └── inference.c
├── tests/
│   └── test_predictions.py
├── arm/
│   └── README.md
└── results/
    └── README.md
```

This is the intended structure. Files will be added as the corresponding stages are implemented.

## 🗺️ Roadmap

- [ ] Define the project specification.
- [ ] Train a small model in Python.
- [ ] Extract and document the model parameters.
- [ ] Implement inference in C.
- [ ] Compare Python and C predictions.
- [ ] Configure ARM cross-compilation.
- [ ] Generate and inspect ARM assembly.
- [ ] Compare compiler optimization settings.
- [ ] Document experimental results.

## 📊 Planned Experiments

The project will investigate:

- Numerical differences between Python and C predictions.
- Agreement between the two implementations.
- Differences in generated assembly across optimization levels.
- Code size and execution time where reliable measurements are available.

Results will be added only after the corresponding experiments have been completed.

## 💻 Development Environment

The project is designed to be developed on a Windows computer using software tools and cross-compilation. Physical hardware is not required for the initial experiments.

ARM compilation, emulation, and actual execution will be documented separately to distinguish what has been compiled, simulated, and measured.

## 📚 Learning Goals

This project is intended to build practical understanding of:

- Machine learning inference
- C programming and numerical computation
- Compiler behavior and optimization
- ARM instruction sets and assembly
- Software testing and reproducible experiments

## 📌 Current Progress

The repository has been initialized. Implementation and experiments have not yet been completed.

Progress, code, tests, and findings will be added incrementally.

## 📄 License

See the [LICENSE](LICENSE) file.
