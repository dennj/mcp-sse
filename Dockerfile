# Use a Python image with uv pre-installed
FROM python:3.11-slim as uv

# Set the working directory
WORKDIR /app

RUN pip install uv

# Copy the necessary files
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen --no-dev --no-editable

# Copy the rest of the application files
COPY . .

# ✅ Copy agents.txt directly to /app/
COPY agents.txt /app/agents.txt

# Expose the port that the server will run on
EXPOSE 8080

# Default command to run the server
CMD ["uv", "run", "weather.py"]
