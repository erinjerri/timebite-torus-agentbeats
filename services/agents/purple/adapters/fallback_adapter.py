# agents/purple/adapters/fallback_adapter.py

class FallbackAdapter:
    """
    Minimal adapter that simulates computer actions.
    Used until OpenClaw or real automation is integrated.
    """

    async def run_action(self, action, params):
        print(f"[Adapter] Running action: {action}")

        if action == "create_task":
            return {
                "status": "ok",
                "message": f"Task created: {params.get('title')}"
            }

        if action == "update_visualization":
            return {
                "status": "ok",
                "message": "Torus visualization updated"
            }

        return {
            "status": "unknown_action"
        }