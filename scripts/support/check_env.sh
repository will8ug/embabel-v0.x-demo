
# Check environment variables

echo "Checking environment variables..."

OPENAI_KEY_MISSING=false
ANTHROPIC_KEY_MISSING=false

if [ -z "${OPENAI_API_KEY}" ]; then
    echo "OPENAI_API_KEY environment variable is not set"
    echo "OpenAI models will not be available"
    echo "Get an API key at https://platform.openai.com/api-keys"
    echo "Please set it with: export OPENAI_API_KEY=your_api_key"
    OPENAI_KEY_MISSING=true
else
    echo "OPENAI_API_KEY set: OpenAI models are available"
fi

if [ -z "${ANTHROPIC_API_KEY}" ]; then
    echo "ANTHROPIC_API_KEY environment variable is not set"
    echo "Claude models will not be available"
    echo "Get an API key at https://www.anthropic.com/api"
    echo "Please set it with: export ANTHROPIC_API_KEY=your_api_key"
    ANTHROPIC_KEY_MISSING=true
else
    echo "ANTHROPIC_API_KEY set: Claude models are available"
fi

if [ "$OPENAI_KEY_MISSING" = true ] && [ "$ANTHROPIC_KEY_MISSING" = true ]; then
    echo "Neither OPENAI_API_KEY nor ANTHROPIC_API_KEY is set."
    echo "Cloud models will not be available. The app will fall back to Ollama."
    if ! curl -s --max-time 2 http://localhost:11434/api/tags >/dev/null; then
        echo "Warning: Ollama not detected on localhost:11434. Make sure it is running."
    fi
fi
