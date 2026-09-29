# Flutter Expense Tracker

A Flutter expense tracker application built as a practical project for learning and applying **Clean Architecture**, **BLoC state management**, **Hive local storage**, and **CRUD operations**.

The application allows users to record income and expenses, view their transaction history, and manage transactions locally on their device.

---

## 📱 About the Project

The main goal of this project is not only to build an expense tracker, but also to understand how different parts of a Flutter application work together using a clean and maintainable architecture.

The project separates the application into:

```text
Presentation
     ↓
Domain
     ↓
Data
     ↓
Hive
```

This separation makes the code easier to understand, test, maintain, and extend.

---

## ✨ Features

* Add income transactions
* Add expense transactions
* View all transactions
* Delete transactions
* Update transactions
* Store transactions locally using Hive
* Display transaction type, amount, description, and date
* Handle loading, success, and failure states using BLoC

---

## 🏗️ Architecture

This project follows a Clean Architecture approach.

```text
┌─────────────────────────────┐
│        Presentation         │
│                             │
│ Pages + BLoC + Events       │
│          + States           │
└──────────────┬──────────────┘
               │
               ↓
┌─────────────────────────────┐
│           Domain            │
│                             │
│ Entities                    │
│ Repository Contracts       │
│ Use Cases                   │
└──────────────┬──────────────┘
               │
               ↓
┌─────────────────────────────┐
│            Data             │
│                             │
│ Models                      │
│ Repository Implementation   │
│ Local Data Source           │
└──────────────┬──────────────┘
               │
               ↓
┌─────────────────────────────┐
│             Hive            │
│       Local Storage         │
└─────────────────────────────┘
```

---

## 📂 Project Structure

```text
lib/
│
├── core/
│   └── error/
│       └── failure.dart
│
├── features/
│   └── transaction/
│       │
│       ├── data/
│       │   ├── datasource/
│       │   │   ├── local_data_source.dart
│       │   │   └── local_data_source_impl.dart
│       │   │
│       │   ├── model/
│       │   │   ├── transaction_model.dart
│       │   │   └── transaction_model.g.dart
│       │   │
│       │   └── repository/
│       │       └── transaction_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── transaction_entity.dart
│       │   │
│       │   ├── repository/
│       │   │   └── transaction_repository.dart
│       │   │
│       │   └── usecase/
│       │       └── transaction_use_case.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── transaction_bloc.dart
│           │   ├── transaction_event.dart
│           │   └── transaction_state.dart
│           │
│           └── page/
│               ├── home_page.dart
│               └── add_transaction_page.dart
│
└── main.dart
```

---

## 🧱 Transaction Entity

The core business object is a `TransactionEntity`.

```dart
class TransactionEntity {
  final int id;
  final double amount;
  final String type;
  final DateTime date;
  final String description;
}
```

A transaction contains:

* `id` — unique transaction identifier
* `amount` — transaction amount
* `type` — income or expense
* `date` — date and time of the transaction
* `description` — transaction description

---

## 🔄 CRUD Operations

The application supports the basic CRUD operations:

```text
Create
   ↓
Read
   ↓
Update
   ↓
Delete
```

### Create

Users can create:

```text
Income
Expense
```

### Read

Users can retrieve:

```text
All Transactions
Single Transaction
```

### Update

An existing transaction can be modified.

### Delete

A transaction can be removed from local storage.

---

## 🧠 BLoC State Management

The project uses **BLoC** to manage transaction-related state.

### Events

```text
GetAllTransactionEvent
GetTransactionEvent
AddIncomeEvent
AddExpenseEvent
UpdateTransactionEvent
DeleteTransactionEvent
```

### States

```text
TransactionInitial
TransactionLoading
TransactionLoaded
TransactionActionSuccess
TransactionFailure
```

The general BLoC flow is:

```text
User Action
    ↓
Event
    ↓
BLoC
    ↓
Use Case
    ↓
Repository
    ↓
Data Source
    ↓
Hive
    ↓
Result
    ↓
New State
    ↓
UI
```

---

## 💾 Local Storage

The application uses **Hive** for local data persistence.

A `TransactionModel` extends the domain `TransactionEntity` and is annotated for Hive storage.

```text
TransactionEntity
        ↓
TransactionModel
        ↓
Hive
```

When data comes back from storage:

```text
Hive
  ↓
TransactionModel
  ↓
TransactionEntity
  ↓
Domain
```

This keeps the data layer separated from the domain layer.

---

## 🧩 Repository Pattern

The domain layer defines the repository contract:

```dart
abstract class TransactionRepository {
  Future<Either<Failure, void>> createTransaction(
    TransactionEntity transaction,
  );

  Future<Either<Failure, void>> updateTransaction(
    TransactionEntity transaction,
  );

  Future<Either<Failure, List<TransactionEntity>>>
      getAllTransaction();

  Future<Either<Failure, TransactionEntity>>
      getTransaction(int id);

  Future<Either<Failure, void>> deleteTransaction(int id);
}
```

The actual implementation is provided by:

```text
TransactionRepositoryImpl
```

This allows the domain layer to depend on an abstraction instead of directly depending on Hive.

---

## 🎯 Use Cases

Each transaction operation has its own use case:

```text
GetAllTransactionUseCase
GetTransactionUseCase
CreateTransactionUseCase
UpdateTransactionUseCase
DeleteTransactionUseCase
```

The use-case layer sits between BLoC and the repository:

```text
BLoC
 ↓
Use Case
 ↓
Repository
```

This keeps business/application logic separated from the presentation layer.

---

## ⚠️ Error Handling

The project uses `fpdart` and `Either` for handling success and failure.

```text
Either<Failure, Success>
```

Conceptually:

```text
             Either
            /      \
       Left         Right
        ↓             ↓
     Failure        Success
```

For example:

```dart
Future<Either<Failure, List<TransactionEntity>>>
```

can return either:

```text
Left(Failure)
```

or:

```text
Right(transactions)
```

---

## 🛠️ Technologies

| Technology     | Purpose                       |
| -------------- | ----------------------------- |
| Flutter        | Application framework         |
| Dart           | Programming language          |
| flutter_bloc   | State management              |
| Hive           | Local database/storage        |
| hive_flutter   | Flutter integration with Hive |
| fpdart         | Functional error handling     |
| build_runner   | Code generation               |
| hive_generator | Hive adapter generation       |

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/flutter-expense-tracker-clean-architecture.git
```

### 2. Open the project

```bash
cd flutter-expense-tracker-clean-architecture
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Generate Hive adapter

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Run the application

```bash
flutter run
```

---

## 📚 What I Learned From This Project

This project was created as a learning project to practice:

* Clean Architecture in Flutter
* Separating domain, data, and presentation layers
* Repository pattern
* Use-case-driven application design
* BLoC event and state management
* Dependency injection
* Hive local storage
* Hive model generation
* CRUD operations
* Functional error handling with `Either`
* Connecting Flutter UI with local persistent data

---

## 🔮 Future Improvements

Possible future features include:

* Edit transaction screen
* Transaction details screen
* Expense and income summaries
* Total balance calculation
* Category support
* Date filtering
* Search transactions
* Charts and statistics
* Monthly expense reports
* Improved transaction validation
* More comprehensive unit and BLoC tests

---

## 🎓 Project Purpose

This project is part of my Flutter learning journey.

The focus is on understanding **how to design and connect a Flutter application using Clean Architecture and BLoC**, while building a real-world application instead of learning each concept in isolation.
