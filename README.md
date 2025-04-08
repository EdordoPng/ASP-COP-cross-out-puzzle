# 🧠 Cross-out Puzzle Solver (ASP)

This project implements a solver for the **Cross-out Puzzle**, using **Answer Set Programming (ASP)** with **Clingo**.

The puzzle consists of a rectangular grid of symbols, and the goal is to determine which symbols to **keep** and which to **cross out**, while satisfying the following constraints:

### ✅ Puzzle Constraints

1. **No repeated symbols** in any row or column (crossed-out symbols are ignored).
2. **Crossed-out symbols must not be adjacent** (no horizontal or vertical adjacency).
3. **Remaining symbols must form a contiguous region**, connected via horizontal/vertical paths.

---

## 📁 Files
project.lp → ASP program that implements the solver

input.lp → Sample input grid

Report.pdf → 📄 Detailed explanation of logic, methodology, testing, and ethical reflections

## 🚀 How to Run

Make sure you have [**Clingo**](https://potassco.org/clingo/) installed (e.g. version 5.7.1), then run:

```bash
clingo project.lp input.lp
```

---


📄 Full Report
For a complete breakdown of the approach, logic, constraints implementation and ethical reflections, see Report.pdf
