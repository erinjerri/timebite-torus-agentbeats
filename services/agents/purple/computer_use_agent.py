# agents/purple/computer_use_agent.py

from typing import Dict, Any

class ComputerUseAgent:
    """
    Purple Agent layer responsible for interacting with the environment.
    """

    def __init__(self, adapter):
        self.adapter = adapter

    async def run_task(self, task: Dict[str, Any]):
        """
        Execute a structured task from the planner.
        """
        action = task.get("action")
        params = task.get("params", {})

        print(f"[PurpleAgent] Executing action: {action}")

        result = await self.adapter.run_action(action, params)

        return {
            "action": action,
            "result": result
        }