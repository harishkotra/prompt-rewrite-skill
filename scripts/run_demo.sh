#!/bin/bash

echo "Starting UPskill + Ollama Demo Flow..."

echo "-----------------------------------"
echo "1. Checking Prerequisites..."
if ! command -v ollama &> /dev/null; then
    echo "Error: ollama not found. Please install from https://ollama.com"
    exit 1
fi

# Simple check if ollama server is responsive
if ! curl -s http://localhost:11434/api/tags > /dev/null; then
     echo "Ollama server does not appear to be running on port 11434."
     echo "Please run 'ollama serve' in a separate terminal."
     exit 1
fi
echo "Ollama is running."

echo "-----------------------------------"
echo "2. Generating Skill..."
bash scripts/generate_skill.sh

echo "-----------------------------------"
echo "3. Evaluating with Ollama..."
bash scripts/eval_local.sh

echo "-----------------------------------"
echo "4. Showing generated skill..."
ls -l skills/prompt-rewrite-optimizer/SKILL.md


echo "-----------------------------------"
echo "Demo Run Complete!"
