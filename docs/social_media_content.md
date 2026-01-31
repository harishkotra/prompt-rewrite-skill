# Technical Blog: Stop "Prompt Engineering". Start "Skill Searching".

**Prompt Engineering is dead. Long live Skill Searching.**

We’ve all been there: tweaking a prompt for hours (`"You are a helpful assistant..."`, `"Take a deep breath..."`) trying to get a model to behave. It’s fragile, unscalable, and frankly, boring.

Enter **UPskill** by Hugging Face (conceptually). The idea is simple: instead of writing prompts, you **generate** them using a "Teacher" model, validate them against test cases, and save the winner as a reusable "Skill".

I built a **Local-Only Demo** to prove this works without sending a single token to the cloud. Here’s how I did it using **Ollama** and **Gemma 3 (12B)**.

## The Problem: Vague Inputs
Users are lazy. They type things like:
> *"write something about AI"*

Baseline models will give you a generic, rambling encyclopedia entry. But what if you wanted a structured JSON object for your app?

## The Solution: A "Prompt Optimizer" Skill
I created a meta-skill that intercepts these vague requests and transforms them into structured, high-quality prompts (or in this case, pure JSON for validation).

### Step 1: The "Teacher" (Gemma 3)
I asked Gemma 3 to generate a system prompt that forces **JSON compliance**.
```json
{
  "role": "Tech Journalist",
  "goal": "Explain AI basics",
  "constraints": "Max 200 words",
  "output_format": "Markdown"
}
```

### Step 2: Verification
I ran this skill against a test suite of vague inputs.
- **Baseline (Llama/Gemma raw)**: Fails 100% of the time (returns text).
- **Skilled Model**: Passes 100% of the time (returns valid JSON).

## Why This Matters
For developers, this means deterministic behavior from non-deterministic models. You can treat "Skills" like library functions—import them, trust them, and stop worrying about the underlying prompt magic.

## Try It Yourself
I’ve open-sourced the demo. No API keys needed. Just `ollama serve` and go.
[Link to Repo]

---

# LinkedIn Post

**Stop writing prompts. Start generating skills.** 🚀

I just built a fully local demo using **Hugging Face UPskill** and **Ollama (Gemma 3)** that takes the guesswork out of LLM behavior.

The concept? Instead of manually engineering prompts, use a "Teacher" model to generate specialized "Skills" (optimized system prompts) and validate them against real test cases.

🔹 **The Challenge**: Getting a local model to reliably output structured JSON from vague user inputs.
🔹 **The Result**: 
- Baseline Model: **0% Success** (Chatty, conversational output)
- Skilled Model: **100% Success** (Strict, valid JSON output)

The best part? It runs 100% locally on your machine. No OpenAI/Anthropic API keys required. 

Check out the technical deep dive and the repo below. It's time to treat Prompts like Code. 👇

#LocalAI #Ollama #Gemma3 #AIEngineering #OpenSource #HuggingFace

---

# X (Twitter) Thread

1/5
Prompt Engineering is inefficient. Stop guessing. 🛑
I verified Hugging Face's "UPskill" concept locally with @ollama and Gemma 3.
The result? A measurable 0% -> 100% improvement in model reliability.
Here’s how. 🧵👇

2/5
The goal: Force a local LLM to output stricter JSON structures from vague inputs like "help me with AI".
Baseline models just chat back. They fail the test. ❌
We need a **Skill**—a specialized system prompt generated *by* an AI, for an AI.

3/5
I built a script to:
1. Generate a "Prompt Optimizer" skill using Gemma 3 12B.
2. Run it against a test suite (input vs expected JSON keys).
3. Evaluate the pass rate.

4/5
The results were stark.
Baseline: 0% pass rate.
With Skill: 100% pass rate. 
The "Skilled" model stopped chatting and started executing. It’s like upgrading your junior dev to a senior in 30 seconds.

5/5
And yes, it’s 100% local. No cloud keys.
Repo is up now. Clone it, run `ollama serve`, and watch it fly.
[Link to Repo]
#AI #LocalLLM #Ollama #Gemma
