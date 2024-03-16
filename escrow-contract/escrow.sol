// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Escrow {
    address public payer;
    address public payee;
    IERC20 public usdc;
    uint256 public amount;
    bool public released = false;

    constructor(address _payer, address _payee, uint256 _amount) {
        payer = _payer;
        payee = _payee;
        usdc = IERC20(0x2F25deB3848C207fc8E0c34035B3Ba7fC157602B);
        amount = _amount;
    }

    function deposit() external {
        require(msg.sender == payer, "Only payer can deposit");
        require(usdc.transferFrom(payer, address(this), amount), "Transfer of USDC failed");
    }

    function release() external {
        require(msg.sender == payer, "Only payer can release the funds");
        require(!released, "Funds are already released");
        released = true;
        require(usdc.transfer(payee, amount), "Transfer of USDC failed");
    }
}