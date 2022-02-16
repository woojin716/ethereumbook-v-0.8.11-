pragma solidity ^0.8.11;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract METoken is StandardToken {
    string public constant name = 'Mastering Ethereum Token';
    string public constant symbol = 'MET';
    uint8 public constant decimals = 2;
    uint constant _initial_supply = 2100000000;

    constructor() public {
        totalSupply_ = _initial_supply;
        balances[msg.sender] = _initial_supply;
        emit Transfer(address(0), msg.sender, _initial_supply);
    }
}
