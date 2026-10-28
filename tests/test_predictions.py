
import json
import math
import re
import subprocess
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REFERENCE_PATH = ROOT / "results" / "model_parameters.json"
EXECUTABLE_PATH = ROOT / "c" / "inference.exe"
TOLERANCE = 1e-9


class TestPythonAndCInference(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        if not EXECUTABLE_PATH.exists():
            raise FileNotFoundError(
                "C executable not found. Compile c/inference.c first."
            )

        with REFERENCE_PATH.open(encoding="utf-8") as file:
            cls.reference = json.load(file)

        cls.w1 = cls.reference["weights"][0]
        cls.w2 = cls.reference["weights"][1]
        cls.bias = cls.reference["bias"]

    def run_c(self, x1, x2):
        result = subprocess.run(
            [
                str(EXECUTABLE_PATH),
                format(x1, ".17g"),
                format(x2, ".17g"),
            ],
            cwd=ROOT,
            capture_output=True,
            text=True,
            check=True,
        )

        output = result.stdout

        score_match = re.search(
            r"Linear score:\s*([-+0-9.eE]+)", output
        )
        probability_match = re.search(
            r"Probability:\s*([-+0-9.eE]+)", output
        )
        class_match = re.search(
            r"Predicted:\s*(\d+)", output
        )

        self.assertIsNotNone(score_match, output)
        self.assertIsNotNone(probability_match, output)
        self.assertIsNotNone(class_match, output)

        return (
            float(score_match.group(1)),
            float(probability_match.group(1)),
            int(class_match.group(1)),
        )

    def assert_matches_python(self, x1, x2, expected_score=None,
                              expected_probability=None,
                              expected_class=None):
        score = self.w1 * x1 + self.w2 * x2 + self.bias
        probability = 1.0 / (1.0 + math.exp(-score))
        predicted_class = int(probability >= 0.5)

        if expected_score is not None:
            self.assertAlmostEqual(
                score, expected_score, delta=TOLERANCE
            )
            self.assertAlmostEqual(
                probability, expected_probability, delta=TOLERANCE
            )
            self.assertEqual(predicted_class, expected_class)

        c_score, c_probability, c_class = self.run_c(x1, x2)

        self.assertAlmostEqual(
            c_score, score, delta=TOLERANCE,
            msg=f"Score mismatch for input ({x1}, {x2})",
        )
        self.assertAlmostEqual(
            c_probability, probability, delta=TOLERANCE,
            msg=f"Probability mismatch for input ({x1}, {x2})",
        )
        self.assertEqual(
            c_class, predicted_class,
            msg=f"Class mismatch for input ({x1}, {x2})",
        )

    def test_all_held_out_test_samples(self):
        samples = self.reference["test_samples"]

        self.assertEqual(
            len(samples), 60,
            "Expected 60 held-out test samples from the 80/20 split.",
        )

        for index, sample in enumerate(samples):
            with self.subTest(sample=index):
                x1, x2 = sample["input"]
                self.assert_matches_python(
                    x1,
                    x2,
                    expected_score=sample["linear_score"],
                    expected_probability=sample["probability"],
                    expected_class=sample["predicted_class"],
                )

    def test_edge_inputs(self):
        edge_inputs = [
            (0.0, 0.0),
            (1.0, 0.0),
            (0.0, 1.0),
            (-5.0, 5.0),
            (5.0, -5.0),
            (0.0, -self.bias / self.w2),
        ]

        for x1, x2 in edge_inputs:
            with self.subTest(x1=x1, x2=x2):
                self.assert_matches_python(x1, x2)


if __name__ == "__main__":
    unittest.main()
