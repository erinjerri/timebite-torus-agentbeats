# services/agents/purple/adapters/fallback_adapter.py

from services.agents.purple.actions.action_registry import ActionRegistry
from services.agents.purple.actions.create_task_action import create_task
from services.agents.purple.actions.update_visualization_action import update_visualization


class FallbackAdapter:
    """
    Minimal adapter that simulates computer actions.
    Used until OpenClaw or real automation is integrated.
    """

    def __init__(self):

        self.registry = ActionRegistry()

        # register available actions
        self.registry.register("create_task", create_task)
        self.registry.register("update_visualization", update_visualization)

    async def run_action(self, action, params):
        print(f"[Adapter] Running action: {action}")
        return self.registry.execute(action, params)