some walkthrough using sage

rather than follow other installation use docker which is simpler
```powershell
(bolsa) PS C:\Users\fadzw\DOwnloads\Trash\Bolsa> docker run -it -v C:/Users/fadzw/Downloads/Trash/Bolsa:/mnt sagemath/sagemath
```
here are the something.py

```python
from sage.all import *

def main():
    # Initialize the finite field
    p = 0x1A0111EA397FE69A4B1BA7B6434BACD764774B84F38512BF6730D2A0F6B0F6241EABFFFEB153FFFFB9FEFFFFFFFFAAAB
    F = GF(p)

    # Create an elliptic curve over the finite field
    a = 0
    b = 4
    E = EllipticCurve(F, [a, b])

    # Define points on the curve
    P = E(0x17F1D3A73197D7942695638C4FA9AC0FC3688C4F9774B905A14E3A3F171BAC586C55E83FF97A1AEFFB3AF00ADB22C6BB,
           0x08B3F481E3AAA0F1A09E30ED741D8AE4FCF5E095D5D00AF600DB18CB2C04B3EDD03CC744A2888AE40CAA232946C5E7E1)
    Q = E(0x13d014b94eb0af5272abe97342bc46f847823114820b07b0cbc9b7d740b39debd61292b4b824f3aaad91fd4b66bfbe92,
           0x904a8e8987a086e68b581d3521b5676a62fc67a864f5b083275877d6e120ecf92ae8e84070cf995cd7bc6fcf848ecf2)

    # Demonstrate point addition
    R = P + Q
    print(f"Point Addition: P + Q = {R}")

    # Demonstrate scalar multiplication
    k = 5
    S = k * P
    print(f"Scalar Multiplication: {k} * P = {S}")

if __name__ == "__main__":
    main()
    
def create_curve(a, b, p):
    """Create an elliptic curve defined by the equation y^2 = x^3 + ax + b over the finite field GF(p)."""
    from sage.all import EllipticCurve, GF
    return EllipticCurve(GF(p), [a, b])

def add_points(P, Q, curve):
    """Add two points P and Q on the elliptic curve."""
    return P + Q

def multiply_point(k, P, curve):
    """Multiply point P by scalar k on the elliptic curve."""
    return k * P
```

here are way to run the python code. also you can use commands like `ls` , `cd /mnt` , `pip install <lib>`
sage: load('/mnt/something.py')
Point Addition: P + Q = (1799126918094223176481990203236740654430561516433592911041614233238153739154467010121767113033592695026998037297637 : 3148363502403923829699492426083917180791793567645568679647084683518951374738804357024682468935150372860016791079052 : 1)
Scalar Multiplication: 5 * P = (2601793266141653880357945339922727723793268013331457916525213050197274797722760296318099993752923714935161798464476 : 3498096627312022583321348410616510759186251088555060790999813363211667535344132702692445545590448314959259020805858 : 1)
