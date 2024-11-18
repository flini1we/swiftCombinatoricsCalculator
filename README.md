# Math Calculator Project
## Overview
This project is a Swift-based application designed to calculate various combinatorial concepts such as permutations, combinations, and placements, both with and without repetition. Additionally, it includes a probability calculator based on urn models. The app provides a user-friendly interface that allows users to select the type of calculation they want to perform and input the necessary values. 

## Features
- **Combinatorial Calculations**: 
  - Permutations with and without repetition.
  - Combinations with and without repetition.
  - Placements with and without repetition.

- **Probability Calculations**:
  - Probability calculations based on urn models, including scenarios where all extracted items are marked and where a specific number of items are marked.
- **User Interface**:
  - A side menu for easy navigation and selection of different calculation types.
  - Dynamic input fields that adapt based on the user's selection.

## Technologies Used
- **Swift**: The application is developed using the Swift programming language, leveraging modern features such as `async/await` and `Task` for handling asynchronous operations efficiently.
- **SwiftMath Framework**: This framework is utilized for performing complex mathematical operations and ensuring accuracy in calculations.
- **Side Menu**: A side menu is implemented to provide a seamless and intuitive user experience, allowing users to navigate between different sections of the app easily.
- **MVC Pattern**: The project is structured using the Model-View-Controller (MVC) design pattern, promoting a clean separation of concerns and making the codebase more maintainable and scalable.
- 
## How to Use
1. **Select Calculation Type**: Start by selecting what you want to calculate – permutations, combinations, or placements. You can choose whether the calculation should be performed with or without repetition.
2. **Input Parameters**: Depending on your selection, input fields for `n`, `k`, `m`, and `r` will be displayed. Enter the necessary values to proceed with the calculation.
3. **Compute Results**: Once the values are entered, the application will compute the results using the selected formula and display the output.
4. **Probability Calculations**: For urn model calculations, input the total number of items (`n`), marked items (`m`), and the number of items extracted (`k`). The app will then calculate the probability based on the selected scenario.
5. 
## Asynchronous Operations
The app uses Swift's `async/await` and `Task` to handle computations that might be resource-intensive, especially when dealing with large factorials or complex probability calculations. This approach ensures that the user interface remains responsive while computations are being processed in the background.

## Conclusion
This Swift application provides a comprehensive tool for performing combinatorial and probability calculations with ease and accuracy. By leveraging modern Swift features and frameworks, the app ensures both performance and user-friendliness. Whether for educational purposes or practical use, this calculator is equipped to handle a variety of combinatorial scenarios.
