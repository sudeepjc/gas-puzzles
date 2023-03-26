// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedArraySort {
    function sortArray(
        uint256[] memory _data
    ) external pure returns (uint256[] memory) {
        // changed the calldata to memory and put an efficient sorting algorithm, this solves the gas problem
        quickSort(_data, 0, _data.length - 1);
        return _data;
    }

    function quickSort(uint[] memory arr, uint left, uint right) private pure {
        uint i = left;
        uint j = right;
        if (i == j) return;
        uint pivot = arr[left + (right - left) / 2];
        while (i < j) {
            while (arr[i] < pivot) i++;
            while (pivot < arr[j]) j--;
            if (i <= j) {
                (arr[i], arr[j]) = (arr[j], arr[i]);
                i++;
                j--;
            }
        }
        if (left < j) quickSort(arr, left, j);
        if (i < right) quickSort(arr, i, right);
    }
}

/*
Compiled 1 Solidity file successfully


  ArraySort
    Payable
      ✔ The functions MUST remain non-payable
    Gas target
           Current gas use:   27806
           The gas target is: 27855
      ✔ The functions MUST meet the expected gas efficiency (56ms)
    Business logic
      1) The functions MUST perform as expected
      ✔ The functions MUST perform as expected
      ✔ The functions MUST perform as expected


  4 passing (761ms)
  1 failing

  1) ArraySort
       Business logic
         The functions MUST perform as expected:
     Error: call revert exception; VM Exception while processing transaction: reverted with panic code 17 [ See: https://links.ethers.org/v5-errors-CALL_EXCEPTION ] (method="sortArray(uint256[])", data="0x4e487b710000000000000000000000000000000000000000000000000000000000000011", errorArgs=[{"type":"BigNumber","hex":"0x11"}], errorName="Panic", errorSignature="Panic(uint256)", reason=null, code=CALL_EXCEPTION, version=abi/5.7.0)
      at Logger.makeError (node_modules/@ethersproject/logger/src.ts/index.ts:269:28)
      at Logger.throwError (node_modules/@ethersproject/logger/src.ts/index.ts:281:20)
      at Interface.decodeFunctionResult (node_modules/@ethersproject/abi/src.ts/interface.ts:427:23)
      at Contract.<anonymous> (node_modules/@ethersproject/contracts/src.ts/index.ts:400:44)
      at step (node_modules/@ethersproject/contracts/lib/index.js:48:23)
      at Object.next (node_modules/@ethersproject/contracts/lib/index.js:29:53)
      at fulfilled (node_modules/@ethersproject/contracts/lib/index.js:20:58)
      at processTicksAndRejections (node:internal/process/task_queues:96:5)
      at runNextTicks (node:internal/process/task_queues:65:3)
      at listOnTimeout (node:internal/timers:528:9)



abcd@Sudeep:~/gas-puzzles$ npx hardhat test test/ArraySort.js 
Compiled 1 Solidity file successfully


  ArraySort
    Payable
      ✔ The functions MUST remain non-payable
    Gas target
           Current gas use:   27806
           The gas target is: 27855
      ✔ The functions MUST meet the expected gas efficiency (57ms)
    Business logic
      1) The functions MUST perform as expected
      ✔ The functions MUST perform as expected
      ✔ The functions MUST perform as expected


  4 passing (722ms)
  1 failing
*/
