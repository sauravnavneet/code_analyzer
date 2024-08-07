# Code Analyzer

ASSIGNMENT: -

------- Write a code in Flutter (even if you've not worked in Flutter that's okay, go to some basic tutorials and start building this - We primarily want to check your approach to things & how do you execute code building) that evaluates the entire application code and provides a performance report of the Flutter project filled with various performance highlights and actionables on what can be improved.

APPROACH: - 

To tackle this situation I went through the following: -
•	Understanding what the assignment is asking for.
•	Going through the flutter’s official documentation on Performance Profiling.
•	Searching the web about different metrics, a app is checked on.
•	Understanding about the different metrics available.
•	Reading documentation about how can I achieve to bring out the metrics in different ways.
•	Trying and testing different methods. 
•	Going through some packages which could help me.
•	Testing and finally reaching to a satisfactory result.

METRICS PROVIDED IN THE APP: - 

1.	STARTUP TIME: - Time taken for the app to render the first frame on the screen.
2.	COMPUTE TIME: - Time taken for the app to compute a piece of code. (Simulated using for loop)
3.	MEMORY USGAE: - Hardcoded number because I couldn’t find any relevant article or documentation for getting memory usage details during dev mode.
4.	FRAME RATE: - Displays the Frame Rate/s.
5.	CODE ANALYZER: - Using Dart’s inbuilt Analyzer, written a code that checks for every dart files in the directory provided and shows three Output:-
•	CYCLOMATIC COMPLEXITY: - It measures the number of linearly independent paths through a program's source code. Lower values are generally better.
Ex-  void main(){
        If()
        Else if()
        Else()
}
       Here, c = 4, ( 3 independent entry – if and one main function entry )

•	CODE SMELLS: - It indicated problems in the code which must be addressed in order to maintain the codebase. Indicates about long methods, refactoring etc.
Ex-  void main (){
     // displaying ad
     // calculating bill
     // showing notification
}
  Here, all the code for these three works are written at one place. But this can       be refactored to three different function to focus on their work only maintaining the readability, usecase etc all at their separate place.

•	PERFORMANCE ISSUES: - Basically read the files and point out any function, or classes which has long methods or nested structure which can lead to more computation time or lower the app’s performance.

ACTIONS: - 

	Refactor the code.
	Seperation of logic.
	Break down bigger methods into smaller ones.
	Remove Dead and Duplicated Codes.

