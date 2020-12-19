# Robo-advisor-and-systematic-trading
Basis, execution, and evaluation of execution strategies used in financial markets, and exploring the use of AI in driving decision making.

In preparation for the Robo advisors and systematic trading course [taught by Prof. Vasant Dhar] at the NYU Stern School of Business.

## Dependencies
Run 
```bash
pip install -r requirements.txt
```

## Portfolio Optimization
- Creating a portfolio with 3 assets from a list of 6 assets [Use of standard tickers used on the NYSE for representing assets].
```python
from roboadvisor.optimizer import PortfolioOptimizer

assets=['TSLA','SPY','GDX','AAPL','FXI','GLD']
optimal_portfolio=PortfolioOptimizer(assets, portfolio_size=5,max_pos=1.0, min_pos=0.0)
```
