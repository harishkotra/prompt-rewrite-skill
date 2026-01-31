#!/bin/bash

# Check if upskill is installed
if ! command -v upskill &> /dev/null; then
    echo "upskill could not be found. Please install it with 'pip install upskill' or check your path."
    exit 1
fi

echo "Generating skill 'prompt-rewrite-optimizer'..."
echo "Target: Rewrite vague prompts into structured prompts with role, goal, constraints, and output format."

# Export environment variables for local Ollama usage
export OPENAI_API_BASE=http://localhost:11434/v1
export OPENAI_API_KEY=local
# Use 'openai' provider alias for Ollama since it provides an OpenAI-compatible endpoint
# or relying on auto-detection if passing full URL. 

echo "----------------------------------------------------------------"
echo "Generating skill 'prompt-rewrite-optimizer' for Local Ollama..."
echo "Using JSON-structured format for measurable optimization."
echo "----------------------------------------------------------------"

# Create skill directory if it doesn't exist
mkdir -p ./skills/prompt-rewrite-optimizer

# Write the SKILL.md optimized for local Gemma3:12b
cat <<EOF > ./skills/prompt-rewrite-optimizer/SKILL.md

# prompt-rewrite-optimizer

## Role
Act as an expert Prompt Engineer.

## Goal
Rewrite vague or simple user prompts into detailed, structured prompts.

## Format
Your output must be a valid JSON object with these keys:
- "role": [The persona]
- "goal": [Specific objective]
- "constraints": [Limitations, word count, style]
- "output_format": [JSON, Markdown, etc.]

## Instructions
1. Analyze the user's vague request.
2. Output ONLY the JSON object.
3. No preamble or markdown code blocks (if possible).

## Example
Input: "write something about AI"
Output:
{
  "role": "Tech Journalist",
  "goal": "Explain AI basics to a beginner audience",
  "constraints": "Use analogies, max 200 words",
  "output_format": "Markdown blog post"
}
EOF

echo "Skill generation complete. Check ./skills/prompt-rewrite-optimizer"
