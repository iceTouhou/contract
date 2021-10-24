//SPDX-License-Identifier: ICETHOU-CODE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/* Very simple BAKA pool ;-) */

contract BakaBankSimplePool is AccessControl {

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    IERC20 public targetToken;
    string public name;

    event Transfer(address to, uint256 value);

    constructor(address tokenAddress, string memory bankName) {
        targetToken = IERC20(tokenAddress);
        name = bankName;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    function bankBalance() public view returns (uint256) {
        return targetToken.balanceOf(address(this));
    }

    function transfer(address to, uint256 value) public onlyRole(ADMIN_ROLE) {
        require(value > 0);
        require(targetToken.balanceOf(address(this)) >= value);
        targetToken.transfer(to, value);
        emit Transfer(to, value);
    }
}
