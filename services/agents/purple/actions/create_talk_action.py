def create_task(params):

    title = params.get("title", "Untitled")

    print(f"[Action] Creating task: {title}")

    return {
        "status": "ok",
        "message": f"Task created: {title}"
    }