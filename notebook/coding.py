""""""
from typing import Dict, List


class Coffee:
    def __init__(self, name: str, price: int, recipe: Dict[str, int]):
        self.name = name
        self.price = price
        self.recipe = recipe

class VendingMachine:
    def __init__(self, stock: List[Coffee]):
        self.stock = stock

    
