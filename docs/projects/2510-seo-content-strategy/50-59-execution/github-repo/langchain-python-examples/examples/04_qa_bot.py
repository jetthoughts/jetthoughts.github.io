"""
Question-Answering Bot with Conversation Memory

This example demonstrates:
- Class-based LangChain application
- Conversation memory management
- Custom prompt templates
- Error handling
- Conversation history tracking

Usage:
    python examples/04_qa_bot.py
"""

from langchain_openai import ChatOpenAI
from langchain.memory import ConversationBufferMemory
from langchain.chains import ConversationChain
from langchain.prompts import PromptTemplate
from dotenv import load_dotenv
import os

load_dotenv()


class PythonAssistant:
    """AI assistant specialized in Python programming help"""

    def __init__(self):
        # Set up LLM
        self.llm = ChatOpenAI(
            model="gpt-4-turbo-preview",
            temperature=0.7,
            api_key=os.getenv('OPENAI_API_KEY')
        )

        # Set up memory to remember conversation context
        self.memory = ConversationBufferMemory(
            return_messages=True,
            memory_key="chat_history"
        )

        # Create custom prompt template
        prompt = PromptTemplate(
            input_variables=["chat_history", "input"],
            template="""You are a helpful Python programming expert.
            Provide clear, practical advice with code examples.
            Be encouraging and reference Python best practices.

            Conversation history: {chat_history}

            Human: {input}
            Assistant:"""
        )

        # Create conversation chain
        self.conversation = ConversationChain(
            llm=self.llm,
            memory=self.memory,
            prompt=prompt,
            verbose=True  # Shows chain execution steps
        )

    def ask(self, question: str) -> str:
        """
        Ask a question and get AI response

        Args:
            question: Question to ask the assistant

        Returns:
            AI assistant's response
        """
        try:
            response = self.conversation.predict(input=question)
            return response
        except Exception as e:
            return f"Error: {str(e)}"

    def get_conversation_history(self) -> dict:
        """
        Get conversation history

        Returns:
            Dictionary containing chat history
        """
        return self.memory.load_memory_variables({})


def main():
    """Main function demonstrating the QA bot"""
    print("=== Python Programming Assistant ===\n")
    print("Ask questions about Python. Type 'quit' to exit.\n")

    assistant = PythonAssistant()

    # Example conversation
    questions = [
        "What's a Python decorator? Give a simple example.",
        "How do I use it with classes?",  # Assistant remembers we're talking about decorators!
    ]

    for i, question in enumerate(questions, 1):
        print(f"Q{i}: {question}")
        response = assistant.ask(question)
        print(f"A{i}: {response}\n")
        print("---\n")

    # Show conversation history
    print("=== Conversation History ===")
    history = assistant.get_conversation_history()
    print(history['chat_history'])


if __name__ == "__main__":
    main()
