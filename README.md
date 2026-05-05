# 🧬 Computational Gene — Entropy-Stable DNA Sequence Evolution

<p align="center">
  <br>
  <b>PDE-Inspired Computational Framework for DNA Sequence Generation & Evolution</b>
</p>

<p align="center">
  <a href="#-quick-start"><img src="https://img.shields.io/badge/⚡_Quick_Start-ff6b6b?style=for-the-badge" alt="Quick Start"></a>
  <a href="#-theory"><img src="https://img.shields.io/badge/📖_Theory-4ecdc4?style=for-the-badge" alt="Theory"></a>
  <a href="#-features"><img src="https://img.shields.io/badge/✨_Features-ffe66d?style=for-the-badge" alt="Features"></a>
  <a href="#-code-overview"><img src="https://img.shields.io/badge/💻_Code-9b59b6?style=for-the-badge" alt="Code"></a>
</p>

---

## ⚡ Quick Start

```matlab
% Clone and run
git clone https://github.com/swap60/Computational_Gene.git
cd Computational_Gene
dna_evolution_model   % Launch DNA evolution simulation
```

**Output:** 6 plots showing entropy decay, GC content evolution, DNA heatmap, surface plots, and convergence analysis.

<details>
<summary><b>📋 System Requirements</b> (click to expand)</summary>

| Component | Requirement |
|-----------|-------------|
| MATLAB | R2021b or newer |
| Toolboxes | Base MATLAB (no additional toolboxes required) |
| Runtime | ~5 seconds for 200 steps |

</details>

---

## 📖 Theory

This project models **DNA sequence evolution** as a discrete dynamical system with entropy constraints, drawing direct analogy from hyperbolic conservation laws and entropy-stable numerical schemes.

### Core Equation

$$S^{n+1} = S^n + \mu \Delta S^n + \mathcal{F}_{\text{selection}}(S^n)$$

Where:
- `Sⁿ` — DNA sequence at generation `n` (encoded as `A=0, T=1, G=2, C=3`)
- `μΔSⁿ` — mutation operator (diffusion-like numerical viscosity)
- `ℱ_selection` — nonlinear selection operator enforcing biological viability

### Entropy Condition

Biological selection acts as an entropy filter:

$$\mathcal{E}(S) = -\sum_i p_i \log p_i, \quad \mathcal{E}(S^{n+1}) \leq \mathcal{E}(S^n)$$

Where `p_i` represents nucleotide or k-mer frequencies. This mimics:
- **Entropy stability** in hyperbolic PDEs
- **Natural selection** filtering non-viable mutations

### Numerical Scheme

| Component | Implementation |
|-----------|----------------|
| **Genetic Flux** | Cell-to-cell base propagation |
| **Adaptive Mutation** | `μ_local = μ · (1 + |lap|/3)` where `lap = S(i+1) - 2S(i) + S(i-1)` |
| **Entropy Monitor** | Rejects mutations that increase entropy |
| **GC-Content Filter** | Accepts only sequences with `0.4 ≤ GC ≤ 0.6` |

---

## ✨ Features

- 🔢 **Discrete Sequence Encoding** — Maps DNA bases `A,T,G,C` → numerical states `0,1,2,3`
- 🧮 **Entropy-Stable Evolution** — Enforces `ℰ(Sⁿ⁺¹) ≤ ℰ(Sⁿ)` at every generation
- ⚡ **Adaptive Mutation Strength** — `μ_local` varies with local sequence irregularity (Laplacian)
- 🧬 **Biological Constraints** — GC-content bounds (`0.4–0.6`) filter non-viable sequences
- 🔄 **Generational Evolution** — Iterative `Sⁿ⁺¹ = ℱ(Sⁿ)` dynamics over 200 timesteps
- 📊 **6 Visualizations** — Entropy decay, GC evolution, heatmap, surface plots, convergence error
- 🎯 **Steady-State Detection** — Automatic convergence detection with tolerance `1e-3`

---

## 💻 Code Overview

### Main Driver: `dna_evolution_model.m`

```matlab
% Parameters
N = 100;        % DNA length
steps = 200;    % Number of time steps
mu = 0.2;       % Mutation strength
dt = 0.1;       % Time step

% Initial DNA (random)
S = randi([0,3], 1, N);

% Evolution loop
for step = 1:steps
    S_new = mutation_step(S, mu);   % Diffusion/mutation
    S = selection(S, S_new);         % Entropy + GC filter
    hist(step, :) = S;
end
```

### Core Functions

| File | Purpose |
|------|---------|
| `mutation_step.m` | Adaptive mutation using local Laplacian (`lap = S(i+1) - 2S(i) + S(i-1)`) |
| `selection.m` | Entropy check + GC-content filter (`0.4 ≤ GC ≤ 0.6`) |
| `entropy_calc.m` | Shannon entropy: `H = -Σ p_i · log(p_i)` |
| `gc_content.m` | GC ratio: `(G + C) / (A + T + G + C)` |

---

## 🛠️ Customization

```matlab
% Example: Higher mutation rate + longer DNA
N = 500;             % Extended sequence length
steps = 500;         % More generations
mu = 0.3;            % Stronger mutation
dt = 0.05;           % Finer timestep

% Run modified evolution
dna_evolution_model;
```

---

## 📂 Repository Structure

```
Computational_Gene/
├── 📄 dna_evolution_model.m    % Main driver (6 plots + steady-state detection)
├── 📄 mutation_step.m          % Adaptive mutation operator (diffusion-like)
├── 📄 selection.m              % Entropy + GC-content biological filter
├── 📄 entropy_calc.m           % Shannon entropy calculator
├── 📄 gc_content.m             % GC ratio calculator
├── 📄 README.md                % This file
└── 📄 LICENSE                  % GPL-3.0
```

---

## 🔬 Research Context

This work connects **numerical PDE analysis** to **computational biology**:

| Biology | Numerical/PDE Analogy |
|---------|----------------------|
| Initial genome | Initial condition `S⁰` |
| Mutation | Numerical perturbation / diffusion |
| Natural selection | Entropy condition / stability filter |
| Survival | Admissible weak solution |

**Key Insight:** Natural selection acts like an entropy condition — among many possible sequences, only biologically valid (entropy-stable) ones survive.

---

## 📚 Citation

If you use this framework in research, please cite:

```bibtex
@software{computational_gene_2024,
  author = {swap60},
  title = {Computational Gene: Entropy-Stable DNA Sequence Evolution},
  url = {https://github.com/swap60/Computational_Gene},
  year = {2024},
  license = {GPL-3.0}
}
```

---

<p align="center">
  <a href="https://github.com/swap60/Computational_Gene/issues">
    <img src="https://img.shields.io/badge/🐛_Report_Issue-red?style=flat-square" alt="Issues">
  </a>
  <a href="https://github.com/swap60/Computational_Gene/fork">
    <img src="https://img.shields.io/badge/🔀_Fork_Project-blue?style=flat-square" alt="Fork">
  </a>
</p>
