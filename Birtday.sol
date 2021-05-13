// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

contract Birthday {
    
    //library usage
    using Address for address payable;
    
    //state variables
    mapping (address => bool) private _members;
    mapping(address => uint256) private _balances;
    address private _owner;
    uint256 private _depositGift;
    uint256 private _totalGift;
    
    //events
    event SetMember(address indexed account, bool status);
    event DeposeGift(address indexed account, uint256 amount);
    
    //constructor
    
    //modifier
    modifier onlyOwner() {
        require(msg.sender == _owner, "Birthday :  only Owner can call this function");
        _;
    }
    
    //function : 
    //  receive, 
    
    //  fallback, 
    
    //  external,
    
    //  public,
    
    function withdrawAll() public onlyOwner {
        uint256 amount = _totalGift;
        _withdraw(msg.sender, amount);
        
    }
    
    function setMembers(address account) public {
        _members[account] = !_members[account];
        emit SetMember(account, _members[account]);
    }
    
    function hasAGift(address account, uint256 amount) public {
        amount += _depositGift;
        _depositGift += _totalGift;
        emit DeposeGift(account, amount);
    }
    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
    
    function owner() public view returns(address) {
        require (_owner ==  0x18623E57807E33724d8ee461e30F79b559A780b6, "Birthday : you are not the owner");
        return _owner;
    }
    
    function isMembers(address account) public  view returns (bool) {
        return _members[account];
    }
    
    function depositGift() public view returns (uint256) {
        return _depositGift;
    }
    
    function totalGift() public view returns (uint256) {
        return _totalGift;
    }
    
    //  internal, 
    
    //  private.
    function _withdraw(address recipient, uint256 amount) private {
        require(_balances[recipient] > 0,"Birthday : you can not withdraw 0 ETH.");
        payable(msg.sender).sendValue(amount);
        
        
    }
}