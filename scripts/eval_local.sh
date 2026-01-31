#!/bin/bash

# Check if upskill is installed
if ! command -v upskill &> /dev/null; then
    echo "upskill could not be found. Please install it with 'pip install upskill' or check your path."
    exit 1
fi

# Check if ollama is running or accessible (simple check)
if ! curl -s http://localhost:11434/api/tags > /dev/null; then
    echo "Warning: reliable connection to Ollama at localhost:11434 not found. Make sure Ollama is running."
fi

echo "Evaluating skill 'prompt-rewrite-optimizer' against baseline..."

# Export for local usage
export OPENAI_API_KEY=local

# Run custom python evaluation script to ensure reliable local execution with Ollama
python scripts/custom_eval.py





echo "Evaluation complete."
