# Prompt Rewrite Skill Demo (Local Ollama + UPskill)

A fully local demonstration of using Hugging Face's **UPskill** library to prevent prompt engineering via "Skill Search".

This demo uses **Ollama** (running `gemma3:12b`) to:
1.  **Generate** a "Prompt Optimizer" skill (conceptually).
2.  **Evaluate** the skill against a baseline model.
3.  **Prove** measurable improvement (0% -> 100% success rate) using a custom JSON-based verification method.

**No Cloud API Keys Required.** Everything runs locally on your machine.

## Prerequisites

1.  **Ollama** installed and running (`ollama serve`).
2.  **Gemma 3 (12B)** model pulled:
    ```bash
    ollama pull gemma3:12b
    ```
3.  **Python 3.10+** installed.

## Setup

1.  Clone the repository and install dependencies:
    ```bash
    pip install -r requirements.txt
    ```

## Usage

Run the full end-to-end demo with a single script:

```bash
bash scripts/run_demo.sh
```

### What Happens?

1.  **Check**: Verifies Ollama is running.
2.  **Generate**: Creates a specialized `prompt-rewrite-optimizer` skill (optimized for JSON output) in the `skills/` directory.
3.  **Evaluate**: Runs 3 test cases ("write something about AI", etc.):
    - **Baseline (Raw Model)**: Fails to produce structured JSON.
    - **Skilled Model**: Successfully outputs the required JSON schemas.
4.  **Result**: Displays a comparison table showing **100% Success** for the skilled model vs 0% for the baseline.

## Directory Structure

```
prompt-skill-demo/
├── README.md               # You are here
├── requirements.txt        # python-dotenv, upskill
├── skills/                 # Generated skills (output of demo)
├── tests/                  # JSON test cases for evaluation
└── scripts/
    ├── run_demo.sh         # Main demo orchestrator
    ├── generate_skill.sh   # Generates the JSON-optimized skill file
    ├── eval_local.sh       # Runs the evaluation step
    └── custom_eval.py      # Custom Python evaluator for reliable local checks
```

## Why JSON?

To strictly measure improvement, the skill forces the model to output **JSON** (`role`, `goal`, `output_format`). The evaluation script checks for these keys.
- **Baseline models** typically chat back conversationally -> **FAIL**.
- **Skilled models** strictly follow the system prompt -> **PASS**.
