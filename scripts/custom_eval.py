import json
import requests
import sys
import os
from time import time

def call_ollama(prompt, system_prompt=None):
    url = "http://localhost:11434/api/generate"
    data = {
        "model": "gemma3:12b",
        "prompt": prompt,
        "stream": False
    }

    if system_prompt:
        data["system"] = system_prompt
    
    try:
        resp = requests.post(url, json=data)
        resp.raise_for_status()
        return resp.json().get('response', '')
    except Exception as e:
        print(f"Error calling Ollama: {e}", file=sys.stderr)
        return ""

def matches_criteria(text, criteria):
    text_lower = text.lower()
    for item in criteria:
        if item.lower() not in text_lower:
            return False
    return True

def main():
    # Load test cases
    try:
        with open('tests/vague_prompts.json', 'r') as f:
            tests = json.load(f)
    except Exception as e:
        print(f"Error loading tests: {e}")
        return

    # Load skill
    try:
        with open('skills/prompt-rewrite-optimizer/SKILL.md', 'r') as f:
            skill_content = f.read()
    except Exception as e:
        skill_content = None
        print(f"Warning: SKILL.md not found. Skill run will fail.")

    print(f"Running {len(tests)} test cases via Ollama (gemma3:12b)...")

    print(f"{'Test':<30} | {'Baseline':<10} | {'With Skill':<10}")
    print("-" * 60)

    baseline_passes = 0
    skill_passes = 0

    for t in tests:
        prompt = t['input']
        criteria = t['expected']['contains']
        
        # Baseline Run
        base_out = call_ollama(prompt)
        base_ok = matches_criteria(base_out, criteria)
        if base_ok: baseline_passes += 1

        # Skill Run
        skill_ok = False
        if skill_content:
            skill_out = call_ollama(prompt, system_prompt=skill_content)
            skill_ok = matches_criteria(skill_out, criteria)
            if skill_ok: skill_passes += 1

        # Print row
        name = (prompt[:27] + '..') if len(prompt) > 27 else prompt
        base_mark = "PASS" if base_ok else "FAIL"
        skill_mark = "PASS" if skill_ok else "FAIL"
        print(f"{name:<30} | {base_mark:<10} | {skill_mark:<10}")

    print("-" * 60)
    
    base_pct = (baseline_passes / len(tests)) * 100
    skill_pct = (skill_passes / len(tests)) * 100
    
    print(f"Baseline Success: {base_pct:.0f}%")
    print(f"Skill Success:    {skill_pct:.0f}%")
    
    improvement = skill_pct - base_pct
    if improvement > 0:
        print(f"\nOptimization Successful! (+{improvement:.0f}% improvement)")
    else:
        print(f"\nNo measurable improvement detected.")

if __name__ == "__main__":
    main()
