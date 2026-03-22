def start_timer(params):

    task = params.get("title")

    print(f"[Action] Starting timer for: {task}")

    return {
        "status": "ok",
        "message": f"Timer started for {task}"
    }