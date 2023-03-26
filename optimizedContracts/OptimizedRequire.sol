// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedRequire {
    uint256 constant COOLDOWN = 1 minutes;
    // Storage value changing from non-zero to non-zero
    uint256 lastPurchaseTime = 1;

    function purchaseToken() external payable {
        uint256 cooldownTime;
        uint256 time = block.timestamp;

        // unchecked block
        unchecked {
            cooldownTime = lastPurchaseTime + COOLDOWN;
        }

        // if block instead of require
        if (msg.value != 0.1 ether) {
            revert();
        }

        require(time > cooldownTime);
        lastPurchaseTime = time;
        // mint the user a token
    }
}

/*
Solution:
  Require
    Gas target
           Current gas use:   26223
           The gas target is: 43317
      ✔ The functions MUST meet the expected gas efficiency (41ms)
    Business logic
      ✔ it should revert if msg.value is not 0.1 ether (88ms)
      ✔ should not allow purchases within the cooldown window (41ms)
      ✔ should allow purchases outside the cooldown window (96ms)
*/
