# services/agents/purple/entrypoint.py

import asyncio

from services.agents.purple.computer_use_agent import ComputerUseAgent
from services.agents.purple.adapters.fallback_adapter import FallbackAdapter


async def main():

    adapter = FallbackAdapter()
    agent = ComputerUseAgent(adapter)

    task = {
        "action": "create_task",
        "params": {
            "title": "Write hackathon demo"
        }
    }
    task = {
    "action": "start_timer",
    "params": {
        "title": "Write hackathon demo"
    }
}
    result = await agent.run_task(task)

    print("[Result]")
    print(result)


if __name__ == "__main__":
    asyncio.run(main())