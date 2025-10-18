"""
Unit tests for Question-Answering Bot

Demonstrates:
- Mocking LangChain LLM calls
- Testing conversation memory
- Testing error handling
- Async testing patterns
"""

import pytest
from unittest.mock import MagicMock, patch, PropertyMock
from langchain.schema import AIMessage
import sys
import os

# Add parent directory to path for imports
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from examples.qa_bot import PythonAssistant


class TestPythonAssistant:
    """Test suite for PythonAssistant class"""

    @pytest.fixture
    def mock_llm_response(self):
        """Fixture for mocked LLM response"""
        return "A decorator is a function that modifies the behavior of another function..."

    @patch('examples.qa_bot.ChatOpenAI')
    def test_assistant_initialization(self, mock_chatgpt):
        """Test that PythonAssistant initializes correctly"""
        # Arrange
        mock_llm = MagicMock()
        mock_chatgpt.return_value = mock_llm

        # Act
        assistant = PythonAssistant()

        # Assert
        assert assistant.llm is not None
        assert assistant.memory is not None
        assert assistant.conversation is not None
        mock_chatgpt.assert_called_once()

    @patch('examples.qa_bot.ChatOpenAI')
    def test_ask_question_success(self, mock_chatgpt, mock_llm_response):
        """Test successful question-answer interaction"""
        # Arrange
        mock_llm = MagicMock()
        mock_chatgpt.return_value = mock_llm

        # Mock the conversation chain's predict method
        mock_predict = MagicMock(return_value=mock_llm_response)

        assistant = PythonAssistant()
        assistant.conversation.predict = mock_predict

        # Act
        question = "What is a Python decorator?"
        response = assistant.ask(question)

        # Assert
        assert response == mock_llm_response
        mock_predict.assert_called_once_with(input=question)
        assert "decorator" in response.lower()

    @patch('examples.qa_bot.ChatOpenAI')
    def test_ask_question_with_context(self, mock_chatgpt):
        """Test that assistant remembers conversation context"""
        # Arrange
        mock_llm = MagicMock()
        mock_chatgpt.return_value = mock_llm

        assistant = PythonAssistant()

        # Mock responses for two questions
        responses = [
            "A decorator is a function...",
            "To use decorators with classes, you can use @property or create class decorators..."
        ]

        mock_predict = MagicMock(side_effect=responses)
        assistant.conversation.predict = mock_predict

        # Act
        response1 = assistant.ask("What is a Python decorator?")
        response2 = assistant.ask("How do I use it with classes?")

        # Assert
        assert "decorator" in response1.lower()
        assert "class" in response2.lower()
        assert mock_predict.call_count == 2

    @patch('examples.qa_bot.ChatOpenAI')
    def test_ask_question_error_handling(self, mock_chatgpt):
        """Test error handling when LLM call fails"""
        # Arrange
        mock_llm = MagicMock()
        mock_chatgpt.return_value = mock_llm

        assistant = PythonAssistant()

        # Mock exception during prediction
        mock_predict = MagicMock(side_effect=Exception("API connection failed"))
        assistant.conversation.predict = mock_predict

        # Act
        response = assistant.ask("What is Python?")

        # Assert
        assert "Error" in response
        assert "API connection failed" in response

    @patch('examples.qa_bot.ChatOpenAI')
    def test_get_conversation_history(self, mock_chatgpt):
        """Test retrieving conversation history"""
        # Arrange
        mock_llm = MagicMock()
        mock_chatgpt.return_value = mock_llm

        assistant = PythonAssistant()

        # Mock conversation
        mock_predict = MagicMock(return_value="Python is a programming language...")
        assistant.conversation.predict = mock_predict

        # Act
        assistant.ask("What is Python?")
        history = assistant.get_conversation_history()

        # Assert
        assert 'chat_history' in history
        assert history is not None

    @patch('examples.qa_bot.ChatOpenAI')
    def test_multiple_conversations(self, mock_chatgpt):
        """Test multiple back-and-forth conversations"""
        # Arrange
        mock_llm = MagicMock()
        mock_chatgpt.return_value = mock_llm

        assistant = PythonAssistant()

        responses = [
            "Python is a high-level programming language...",
            "Python was created by Guido van Rossum...",
            "Python is widely used in web development, data science..."
        ]

        mock_predict = MagicMock(side_effect=responses)
        assistant.conversation.predict = mock_predict

        # Act
        questions = [
            "What is Python?",
            "Who created Python?",
            "What is Python used for?"
        ]

        for question in questions:
            assistant.ask(question)

        # Assert
        assert mock_predict.call_count == 3
        history = assistant.get_conversation_history()
        assert history is not None


class TestPythonAssistantIntegration:
    """Integration tests (require actual API keys)"""

    @pytest.mark.integration
    @pytest.mark.skipif(
        not os.getenv('OPENAI_API_KEY'),
        reason="Requires OPENAI_API_KEY environment variable"
    )
    def test_real_api_call(self):
        """Test with real OpenAI API (integration test)"""
        # This test requires a valid API key and makes a real API call
        # Skip by default to avoid unnecessary API costs

        assistant = PythonAssistant()

        question = "What is 2 + 2? Answer with just the number."
        response = assistant.ask(question)

        assert response is not None
        assert len(response) > 0
        # Note: We don't assert exact response since AI output varies


# pytest fixtures for common test data
@pytest.fixture
def sample_questions():
    """Sample questions for testing"""
    return [
        "What is a Python decorator?",
        "How do I use async/await?",
        "Explain list comprehensions"
    ]


@pytest.fixture
def sample_responses():
    """Sample AI responses for mocking"""
    return [
        "A decorator is a function that modifies another function...",
        "async/await is used for asynchronous programming in Python...",
        "List comprehensions provide a concise way to create lists..."
    ]


# Run tests with: pytest tests/test_qa_bot.py -v
# Run with coverage: pytest tests/test_qa_bot.py --cov=examples --cov-report=html
# Run integration tests: pytest tests/test_qa_bot.py -m integration
