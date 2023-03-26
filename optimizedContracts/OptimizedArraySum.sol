// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedArraySum {
    uint256[] array;

    function setArray(uint256[] calldata _array) external {
        require(_array.length <= 10, 'too long');
        array = _array;
    }

    function getArraySum() external view returns (uint256) {
        // Not sure if this is the solutions. But the puzzle did get solved.
        if (array.length == 0) return 0;

        uint256 sum;

        for (uint256 i = 0; i < array.length; i++) {
            sum += array[i];
        }

        return sum;
    }
}

/*
Compiled 1 Solidity file successfully


  ArraySum
    Payable
      ✔ The functions MUST remain non-payable
    Gas target
           Current gas use:   23386
           The gas target is: 23396
      ✔ The functions MUST meet the expected gas efficiency
    Business logic
      ✔ The functions MUST perform as expected (134ms)
      ✔ should not overflow (55ms)


  4 passing (771ms)

  */
