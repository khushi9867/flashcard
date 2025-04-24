import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Flashcard {
  final String question;
  final String answer;
  final String topic;
  bool isBookmarked;

  Flashcard({
    required this.question,
    required this.answer,
    required this.topic,
    this.isBookmarked = false,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS & IT Flashcards',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
      ),
      home: FlashcardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FlashcardPage extends StatefulWidget {
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage>
    with SingleTickerProviderStateMixin {
  late List<Flashcard> flashcards;
  int currentCardIndex = 0;
  bool showAnswer = false;
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  bool isDarkMode = false;
  bool isQuizMode = false;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    flashcards = [
      Flashcard(
        question: 'What is an algorithm?',
        answer: 'A set of rules to solve a problem in a finite number of steps.',
        topic: 'Algorithms',
      ),
      Flashcard(
        question: 'What does HTML stand for?',
        answer: 'HyperText Markup Language.',
        topic: 'Web Development',
      ),
      Flashcard(
        question: 'What is a database?',
        answer: 'An organized collection of structured information or data.',
        topic: 'Databases',
      ),
      Flashcard(
        question: 'What is the difference between C and C++?',
        answer: 'C is procedural; C++ supports object-oriented programming.',
        topic: 'Programming Languages',
      ),
      Flashcard(
        question: 'What is a class in OOP?',
        answer: 'A blueprint to create objects, encapsulating data and behavior.',
        topic: 'OOP',
      ),
      Flashcard(
        question: 'What is recursion?',
        answer: 'A function calling itself to solve a smaller sub-problem.',
        topic: 'Algorithms',
      ),
       Flashcard(
      question: 'What is an algorithm?',
      answer: 'A set of rules to solve a problem in a finite number of steps.',
      topic: 'Algorithms',
    ),
    Flashcard(
      question: 'What does HTML stand for?',
      answer: 'HyperText Markup Language.',
      topic: 'Web Development',
    ),
    Flashcard(
      question: 'What is a database?',
      answer: 'An organized collection of structured information or data.',
      topic: 'Databases',
    ),
    Flashcard(
      question: 'What is the difference between C and C++?',
      answer: 'C is procedural; C++ supports object-oriented programming.',
      topic: 'Programming Languages',
    ),
    Flashcard(
      question: 'What is a class in OOP?',
      answer: 'A blueprint to create objects, encapsulating data and behavior.',
      topic: 'OOP',
    ),
    Flashcard(
      question: 'What is recursion?',
      answer: 'A function calling itself to solve a smaller sub-problem.',
      topic: 'Algorithms',
    ),

    // New flashcards for the topics you mentioned

    // Cyber Security
    Flashcard(
      question: 'What is a firewall?',
      answer: 'A network security system that monitors and controls incoming and outgoing network traffic.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'Define phishing.',
      answer: 'A type of cyber attack where fraudulent communications appear to come from a trusted source, typically through email.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'What is encryption and why is it important in cybersecurity?',
      answer: 'Encryption is the process of converting data into a code to prevent unauthorized access. It is essential to protect sensitive information.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'What is the difference between a virus and a worm?',
      answer: 'A virus requires user interaction to spread, while a worm can spread independently over networks.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'What is a DDoS attack?',
      answer: 'Distributed Denial of Service (DDoS) is an attack aimed at overwhelming a server with traffic, making it unavailable.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'What is multi-factor authentication (MFA)?',
      answer: 'MFA is a security mechanism that requires more than one form of verification to gain access to a system.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'What does VPN stand for, and how does it enhance security?',
      answer: 'VPN stands for Virtual Private Network, and it secures your internet connection by encrypting data and masking your IP address.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'What is the role of an ethical hacker?',
      answer: 'An ethical hacker tests systems for vulnerabilities and helps secure them against malicious attacks.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'Define SQL Injection.',
      answer: 'SQL Injection is a code injection technique that exploits vulnerabilities in an application’s software by inserting malicious SQL queries.',
      topic: 'Cyber Security',
    ),
    Flashcard(
      question: 'What is ransomware?',
      answer: 'Ransomware is a type of malicious software that locks or encrypts a victim’s data and demands payment to restore access.',
      topic: 'Cyber Security',
    ),

    // Android Studio
    Flashcard(
      question: 'What is Android Studio and why is it used?',
      answer: 'Android Studio is an integrated development environment (IDE) for building Android apps using Java or Kotlin.',
      topic: 'Android Studio',
    ),
    Flashcard(
      question: 'How can you optimize performance in Android applications?',
      answer: 'Performance can be optimized by reducing layout complexity, using efficient data structures, and minimizing memory usage.',
      topic: 'Android Studio',
    ),
    Flashcard(
      question: 'What is the Android Manifest file used for?',
      answer: 'The Android Manifest file declares essential information about the app to the Android operating system, such as permissions and activities.',
      topic: 'Android Studio',
    ),
    Flashcard(
      question: 'Explain the difference between `Intent` and `PendingIntent` in Android.',
      answer: 'An Intent is a message to perform a specific action, while PendingIntent allows you to pass an Intent to another app for future execution.',
      topic: 'Android Studio',
    ),
    Flashcard(
      question: 'What is the purpose of `RecyclerView` in Android?',
      answer: '`RecyclerView` is a flexible and efficient container for displaying large datasets by recycling views.',
      topic: 'Android Studio',
    ),
    Flashcard(
      question: 'What is the Android lifecycle, and why is it important for app development?',
      answer: 'The Android lifecycle refers to the various states an app goes through, which helps developers manage resources and optimize performance.',
      topic: 'Android Studio',
    ),

    // Programming Languages (Python, Java, C, C++)
    Flashcard(
      question: 'What is the difference between Python 2 and Python 3?',
      answer: 'Python 3 introduced syntax changes and improved functionality, such as print being a function and integer division behavior.',
      topic: 'Programming Languages',
    ),
    Flashcard(
      question: 'What are the key features of Java\'s object-oriented programming model?',
      answer: 'Java supports features like inheritance, encapsulation, polymorphism, and abstraction in OOP.',
      topic: 'Programming Languages',
    ),
    Flashcard(
      question: 'How do you manage memory in C?',
      answer: 'Memory in C is managed using `malloc` for dynamic memory allocation and `free` for deallocating memory.',
      topic: 'Programming Languages',
    ),
    Flashcard(
      question: 'What is a pointer in C++?',
      answer: 'A pointer in C++ is a variable that stores the memory address of another variable.',
      topic: 'Programming Languages',
    ),
    Flashcard(
      question: 'What is the use of a `lambda` function in Python?',
      answer: 'A `lambda` function is a small anonymous function defined with the `lambda` keyword.',
      topic: 'Programming Languages',
    ),
    Flashcard(
      question: 'Explain the concept of inheritance in Java.',
      answer: 'Inheritance is a mechanism in Java where one class acquires the properties and behaviors of another class.',
      topic: 'Programming Languages',
    ),
    Flashcard(
      question: 'What is a constructor in C++?',
      answer: 'A constructor in C++ is a special member function used to initialize objects when they are created.',
      topic: 'Programming Languages',
    ),
    Flashcard(
      question: 'What is the difference between `==` and `===` in JavaScript?',
      answer: '`==` compares values with type coercion, while `===` compares values without type coercion.',
      topic: 'Programming Languages',
    ),

    // IT Act and Law
    Flashcard(
      question: 'What is the Information Technology Act, 2000 (IT Act)?',
      answer: 'The IT Act is an Indian law that provides a legal framework for electronic governance and cybercrime penalties.',
      topic: 'IT Act and Law',
    ),
    Flashcard(
      question: 'What are the legal consequences of hacking under the IT Act?',
      answer: 'Hacking can lead to imprisonment for up to 3 years or a fine of up to 5 lakh rupees.',
      topic: 'IT Act and Law',
    ),
    Flashcard(
      question: 'Explain the term \'cybercrime\' as per Indian law.',
      answer: 'Cybercrime refers to criminal activities that involve the use of computers and networks, such as hacking and identity theft.',
      topic: 'IT Act and Law',
    ),
    Flashcard(
      question: 'What is the role of the CERT-In in India?',
      answer: 'CERT-In (Indian Computer Emergency Response Team) is responsible for handling cybersecurity incidents and providing guidelines.',
      topic: 'IT Act and Law',
    ),
    Flashcard(
      question: 'Define digital signature in the context of the IT Act.',
      answer: 'A digital signature is a secure way to authenticate electronic documents, ensuring their integrity and origin.',
      topic: 'IT Act and Law',
    ),

    // AI and Machine Learning
    Flashcard(
      question: 'What is the difference between AI and machine learning?',
      answer: 'AI refers to systems that simulate human intelligence, while machine learning is a subset of AI that focuses on learning from data.',
      topic: 'AI and Machine Learning',
    ),
    Flashcard(
      question: 'Explain supervised learning with an example.',
      answer: 'Supervised learning involves training a model using labeled data. Example: Predicting house prices based on historical data.',
      topic: 'AI and Machine Learning',
    ),
    Flashcard(
      question: 'What is deep learning?',
      answer: 'Deep learning is a subset of machine learning that uses neural networks with multiple layers to model complex patterns.',
      topic: 'AI and Machine Learning',
    ),
    Flashcard(
      question: 'What is overfitting in machine learning?',
      answer: 'Overfitting occurs when a model learns the details of the training data too well, leading to poor generalization on new data.',
      topic: 'AI and Machine Learning',
    ),
    Flashcard(
      question: 'What is a neural network?',
      answer: 'A neural network is a set of algorithms designed to recognize patterns by mimicking how the human brain works.',
      topic: 'AI and Machine Learning',
    ),
    Flashcard(
      question: 'What is the purpose of activation functions in neural networks?',
      answer: 'Activation functions introduce non-linearity to the model, allowing it to learn complex patterns.',
      topic: 'AI and Machine Learning',
    ),

    // Software Engineering (SDLC Model)
    Flashcard(
      question: 'What are the different phases of the SDLC (Software Development Life Cycle)?',
      answer: 'The SDLC phases include Planning, Design, Development, Testing, Deployment, and Maintenance.',
      topic: 'Software Engineering',
    ),
    Flashcard(
      question: 'Explain the Agile model in software development.',
      answer: 'Agile is an iterative software development methodology focused on delivering small, incremental improvements.',
      topic: 'Software Engineering',
    ),
    Flashcard(
      question: 'What is the Waterfall model in software engineering?',
      answer: 'Waterfall is a linear and sequential model where each phase must be completed before moving to the next.',
      topic: 'Software Engineering',
    ),
    Flashcard(
      question: 'Define the Spiral model in SDLC.',
      answer: 'The Spiral model combines iterative development with the systematic approach of Waterfall, focusing on risk management.',
      topic: 'Software Engineering',
    ),
    Flashcard(
      question: 'What is the V-Model in software development?',
      answer: 'The V-Model emphasizes verification and validation, where each development phase is associated with a corresponding testing phase.',
      topic: 'Software Engineering',
    ),
    Flashcard(
      question: 'What is prototyping in SDLC?',
      answer: 'Prototyping involves creating a working model of the software to understand requirements and gather user feedback.',
      topic: 'Software Engineering',
    ),

    // Software Testing
    Flashcard(
      question: 'What is the difference between functional and non-functional testing?',
      answer: 'Functional testing checks if the software functions as expected, while non-functional testing evaluates performance, usability, etc.',
      topic: 'Software Testing',
    ),
    Flashcard(
      question: 'Define unit testing.',
      answer: 'Unit testing involves testing individual components of the software to ensure they work correctly.',
      topic: 'Software Testing',
    ),
    Flashcard(
      question: 'What is regression testing?',
      answer: 'Regression testing ensures that new code changes do not affect the existing functionality of the software.',
      topic: 'Software Testing',
    ),
    Flashcard(
      question: 'What is the difference between black-box and white-box testing?',
      answer: 'Black-box testing focuses on testing functionality without looking at the internal code, while white-box testing involves testing the internal logic.',
      topic: 'Software Testing',
    ),
    Flashcard(
      question: 'What is the purpose of stress testing in software testing?',
      answer: 'Stress testing evaluates how the software performs under extreme conditions, such as heavy load or high traffic.',
      topic: 'Software Testing',
    ),
    Flashcard(
      question: 'What is acceptance testing?',
      answer: 'Acceptance testing verifies if the software meets the requirements and is ready for deployment.',
      topic: 'Software Testing',
    ),
    ];

    // Randomize cards
    flashcards.shuffle(Random());

    // Initialize animation controller
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextCard() {
    setState(() {
      showAnswer = false;
      currentCardIndex = (currentCardIndex + 1) % flashcards.length;
    });
  }

  void prevCard() {
    setState(() {
      showAnswer = false;
      currentCardIndex = (currentCardIndex - 1 + flashcards.length) % flashcards.length;
    });
  }

  void toggleAnswer() {
    if (showAnswer) {
      _controller.reverse().then((_) {
        setState(() {
          showAnswer = false;
        });
      });
    } else {
      _controller.forward(from: 0).then((_) {
        setState(() {
          showAnswer = true;
        });
      });
    }
  }

  void toggleBookmark() {
    setState(() {
      flashcards[currentCardIndex].isBookmarked =
          !flashcards[currentCardIndex].isBookmarked;
    });
  }

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void startQuizMode() {
    setState(() {
      isQuizMode = true;
      currentCardIndex = 0;
      correctAnswers = 0;
    });
  }

  void submitAnswer(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        correctAnswers++;
      });
    }

    setState(() {
      showAnswer = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (currentCardIndex < flashcards.length - 1) {
        setState(() {
          currentCardIndex++;
          showAnswer = false;
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Quiz Completed'),
            content: Text('Your score is $correctAnswers/${flashcards.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isQuizMode = false;
                    currentCardIndex = 0;
                  });
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = flashcards[currentCardIndex];

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Color(0xFFF1F1F1),
      appBar: AppBar(
        title: Text('CS & IT Flashcards'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleDarkMode,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add logic to open a dialog for adding new flashcards
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter
            Text(
              isQuizMode
                  ? 'Question ${currentCardIndex + 1} of ${flashcards.length}'
                  : 'Card ${currentCardIndex + 1} of ${flashcards.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),

            // Flip Card
            AnimatedBuilder(
              animation: _flipAnimation,
              builder: (context, child) {
                final isFront = _flipAnimation.value < 0.5;

                return Transform(
                  transform: Matrix4.rotationY(pi * _flipAnimation.value),
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Transform(
                      transform: isFront ? Matrix4.identity() : Matrix4.rotationY(pi),
                      alignment: Alignment.center,
                      child: Text(
                        isFront
                            ? 'Q: ${flashcards[currentCardIndex].question}'
                            : 'A: ${flashcards[currentCardIndex].answer}',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: isFront ? FontStyle.normal : FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40),

            // Show/Hide Button
            ElevatedButton.icon(
              onPressed: toggleAnswer,
              icon: Icon(showAnswer ? Icons.visibility_off : Icons.visibility),
              label: Text(showAnswer ? 'Hide Answer' : 'Show Answer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 110, 45, 222),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Bookmark Button
            IconButton(
              icon: Icon(
                flashcard.isBookmarked
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: Colors.deepPurple,
              ),
              onPressed: toggleBookmark,
            ),

            SizedBox(height: 20),

            // Navigation Buttons
            if (!isQuizMode) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: prevCard,
                    icon: Icon(Icons.arrow_back),
                    label: Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade100,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: nextCard,
                    icon: Icon(Icons.arrow_forward),
                    label: Text('Next'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade200,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Quiz Mode Button
            if (!isQuizMode)
              ElevatedButton(
                onPressed: startQuizMode,
                child: Text('Start Quiz'),
              ),

            // Quiz Answer Buttons
            if (isQuizMode) ...[
              ElevatedButton(
                onPressed: () => submitAnswer(true),
                child: Text('True'),
              ),
              ElevatedButton(
                onPressed: () => submitAnswer(false),
                child: Text('False'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
