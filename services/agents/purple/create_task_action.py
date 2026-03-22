def create_task(params):

    title = params.get("title", "Untitled Task")

    print(f"[Action] Creating task: {title}")

    return {
        "status": "success",
        "task_title": title
    }