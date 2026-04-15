# Petstore Test Automation

This project uses Robot Framework for automated testing and manages dependencies with the [uv](https://github.com/astral-sh/uv) package manager.

## Install dependencies

```
uv sync && source .venv/bin/activate
```

## Running Robot Framework tests

To execute the Robot Framework test suite (e.g., `tests/test_robot.robot`) and store results in the `results` directory:

```
uv run python -m robot --outputdir results tests/test_robot.robot
```

The `results` directory will contain the generated output files (e.g., `output.xml`, `log.html`, `report.html`).