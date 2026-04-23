import json

from a2a.server.tasks import TaskUpdater
from a2a.types import DataPart, Message, Part, TaskState, TextPart
from a2a.utils import get_message_text, new_agent_text_message


class PurpleAgent:
    async def run(self, message: Message, updater: TaskUpdater) -> None:
        text = (get_message_text(message) or "").strip()

        await updater.update_status(
            TaskState.working,
            new_agent_text_message("Analyzing scenario and proposing reallocation..."),
        )

        proposal = self._proposal_for(text)

        await updater.add_artifact(
            parts=[Part(root=DataPart(kind="data", data=proposal))],
            name="reallocation_proposal",
        )

        await updater.add_artifact(
            parts=[Part(root=TextPart(kind="text", text=json.dumps(proposal, indent=2)))],
            name="reallocation_proposal_text",
        )

    def _proposal_for(self, text: str) -> dict:
        normalized = text.lower()
        to_project = "Hackathon Repo"
        from_project = "Job Search"
        hours = 2

        if "startup" in normalized and "job" not in normalized:
            from_project = "Startup Repo"

        return {
            "from_project": from_project,
            "to_project": to_project,
            "hours": hours,
            "reason": "Hackathon is behind plan and is the highest priority for the demo. Reallocating time increases completion odds.",
            "constraints": ["demo-safe", "deterministic", "explainable"],
        }

