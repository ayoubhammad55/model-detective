
import json
import re
import subprocess
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class TestPythonAndCInference(unittest.TestCase):
    def test_c_matches_python_reference(self):
        reference_path = ROOT / "results" / "model_parameters.json"
        executable_path = ROOT / "c" / "inference.exe"

        self.assertTrue(
            executable_path.exists(),
            "C executable not found. Compile c/inference.c first."
        )

        with reference_path.open(encoding="utf-8") as file:
            reference = json.load(file)

        result = subprocess.run(
            [str(executable_path)],
            cwd=ROOT,
            capture_output=True,
            text=True,
            check=True,
        )

        output = result.stdout

        score = float(
            re.search(r"Linear score:\s+([-+0-9.eE]+)", output).group(1)
        )
        probability = float(
            re.search(r"Probability:\s+([-+0-9.eE]+)", output).group(1)
        )
        predicted_class = int(
            re.search(r"Predicted:\s+(\d+)", output).group(1)
        )

        self.assertAlmostEqual(
            score, reference["linear_score"], delta=1e-9
        )
        self.assertAlmostEqual(
            probability, reference["probability"], delta=1e-9
        )
        self.assertEqual(
            predicted_class, reference["predicted_class"]
        )


if __name__ == "__main__":
    unittest.main()
