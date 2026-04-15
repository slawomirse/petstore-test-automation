# Petstore Test Automation

This project uses Robot Framework for automated testing and manages dependencies with the [uv](https://github.com/astral-sh/uv) package manager.

## Install dependencies

```
uv sync && source .venv/bin/activate
```

## Run and stop application

Start application
```
docker compose up -d
```

Stop application
```
docker compose down
```

Stop application and remove volumes
```
docker compose down -v
```

## Running Robot Framework tests

To execute the Robot Framework test suite (e.g., `tests/test_robot.robot`) and store results in the `results` directory:

```
uv run python -m robot --outputdir results tests/test_robot.robot
```
Run robot tests using tags
```
uv run python -m robot --outputdir results --include smoke tests/api
```

The `results` directory will contain the generated output files (e.g., `output.xml`, `log.html`, `report.html`).