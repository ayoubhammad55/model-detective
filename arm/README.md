# ARM64 Inference Validation

## Objective

Validate that the C inference program compiles for AArch64 Linux and runs under emulation.

## Build

Cross-compiled on Windows using the Arm GNU Toolchain for aarch64-none-linux-gnu.

Source: c/inference.c
Output: arm/inference_arm

## Execution

Run under QEMU user-mode emulation in Ubuntu on WSL2:

    qemu-aarch64 -L "$SYSROOT" ./arm/inference_arm

## Validation result

- Linear score: -3.788110560018
- Probability: 0.022137186201
- Predicted class: 0

The results match the native C inference output at the displayed precision.

## Limitations

QEMU validates execution in an emulated environment. It does not measure performance on physical ARM hardware.
