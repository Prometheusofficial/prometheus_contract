/**
 *Submitted for verification at BscScan.com on 2021-11-10
*/

pragma solidity ^0.6.0;
// SPDX-License-Identifier: GPL-3.0-or-later
interface IERC20{
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external  ;
}
contract LockLP{
    address public  pancakeLP = address(0xE77F1D2c2d1631A7a5e50134B1cbe4f7c264b682);
    
    uint256 public startTime ;
    uint256 public lockTimelen = 180 days;
    address public owner;
    
    constructor() public{
        startTime = now;
        owner = msg.sender;
    }
    
    function balanceOfPancakeLP() public view returns(uint256){
        return IERC20(pancakeLP).balanceOf(address(this));
    }
    
    function withdraw(address tokenAddr,address to ) public {
        require(msg.sender == owner,"only owner");
        if(pancakeLP == tokenAddr){
            require(now >= startTime + lockTimelen,"only unlock");
        }
        
        IERC20(tokenAddr).transfer(to,balanceOfPancakeLP());
    }
    
}