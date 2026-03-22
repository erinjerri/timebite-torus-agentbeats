class ActionRegistry:

    def __init__(self):
        self.actions = {}

    def register(self, name, fn):
        self.actions[name] = fn

    def execute(self, name, params):

        if name not in self.actions:
            raise ValueError(f"Unknown action: {name}")

        return self.actions[name](params)