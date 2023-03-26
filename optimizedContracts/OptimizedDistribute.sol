// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedDistribute {
    // Making address immutable saves 8000 gas
    address payable public immutable contributor1;
    address payable public immutable contributor2;
    address payable public immutable contributor3;
    address payable public immutable contributor4;
    // Making createTimeimmutable save around 2200 gas
    uint256 public immutable endTime;

    constructor(address[4] memory _contributors) payable {
        contributor1 = payable(_contributors[0]);
        contributor2 = payable(_contributors[1]);
        contributor3 = payable(_contributors[2]);
        contributor4 = payable(_contributors[3]);
        endTime = block.timestamp + 1 weeks;
    }

    function distribute() external {
        require(block.timestamp > endTime, 'cannot distribute yet');

        // Bitshifting saves 50 units of gas
        uint256 amount = address(this).balance >> 2;

        // send vs transfer: send is cheaper saves about 50+ gas
        contributor1.send(amount);
        contributor2.send(amount);
        contributor3.send(amount);
        // selfdesctuct saves around 4000 gas
        selfdestruct(contributor4);
    }
}
