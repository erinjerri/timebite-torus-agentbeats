def get_llm_hint(prompt: str):

    return {
        "status": "stub",
        "message": "LLM not connected yet",
        "prompt_preview": prompt[:120]
    }