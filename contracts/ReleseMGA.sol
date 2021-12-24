// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ReleseMGA is Ownable{
    using SafeMath for *;
    using SafeERC20 for IERC20;
    
    mapping(address => bool) public manager;
    IERC20 public mga;
    
    /*uint256 public tgeBlock;
    mapping(address => lockS) public preSeed;
    mapping(address => lockS) public seed;
    mapping(address => lockS) public privateRoundOne;
    mapping(address => lockS) public privateRoundTwo;
    mapping(address => lockS) public lanchPad;
    mapping(address => lockS) public advisers;
    mapping(address => lockS) public teams;
    
    mapping(address => uint256) public userFlage ;// 1 preSeed,2,seed,3,privateRoundOne,4,privateRoundTwo,5,lanchPad,advisers,6,Team

    struct lockS{
        uint256 amount;
        uint256 fristTimeReleaseAmount,
        uint256 startBlock; // startBlock;
        uint256 perBlock; // per block  release 
        uint256 changeBlock; // 
        uint256 afterPerBlcok;
        uint256 endBlock; 
        uint256 cleimBlock; // this is user cleim block heght
    }
    
    struct lockTeamS{
        uint256 amount;
        uint256 startBlock;
        uint256 perBlock;
        uint256 changeBlock;
        uint256 afterPerBlcok;
    }
    
    modifier onlyManger() {
        require(manager[msg.sender],"only manager");
        _;
    }
    
    modifier onlyStartTeg(){
        require(block.timestamp >= tgeTime && tgeTime != 0,"not start tge");
        _;
    }
    
    constructor (IERC20 _mga ) {
        manager[msg.sender] = true;
        mga = _mga;

    }

    function setPreSeed(address[] memory users, uint256[] memory lockAmounts) public onlyManger{
        uint256 len = users.length;
        require(len != lockAmounts.length,"setPreSeed:lenght not require");
        uint256 tempAmount ;
        for(uint256 i = 0; i < len; i++){
            lockS storage ls = preSeed[users[i]];
            
            ls.amount = lockAmounts[i];
            ls.lastEpoch = 0;
            
            uint256 tenPer = lockAmounts[i].mul(10).div(100);
            uint256 fivePer = lockAmounts[i].mul(5).div(100);
            
            //ls.epochAmount[1] = fivePer;
            
            for(uint8 i = 2; i <= 14; i++ ){
                if(i > 7){
                    ls.epochAmount[i] = fivePer;
                }else{
                    ls.epochAmount[i] = tenPer;
                }
                
            }
        }
    }
    
    function withdrawPreSeed() public onlyStartTeg{
        //uint256 nowTime = bool.timestamp;
        //uint256 canWithdrawAmount
        
    }
    
    function canWithdrawPreSee(uint256 time,address user) internal  returns(uint256 canPreSeed,uint256 curEpoch){
        canPreSeed = 0;
        lockS storage ls = preSeed[user];
        
        if(ls.amount != 0 ){
            
            curEpoch = getTimeEpoch(time);
            if(curEpoch == 0){
               // check firstTeg 
               if(!ls.epochWithdrawFlag[1]){
                   canPreSeed = ls.epochAmount ;
                   ls.epochWithdrawFlag[1] = true;
               }
            }else if(curEpoch > 0){
                if(!ls.firstWithdrawFlage){
                   canPreSeed = canPreSeed.add(ls.firstAmount);
                }
                uint256 overEpoch = curEpoch > ls.lastEpoch?  curEpoch.sub(ls.lastEpoch) : 0;
                if(overEpoch > 0){
                    
                }
            }
        }
        
        
        
    }
    
    function getTimeEpoch(uint256 time) public view returns(uint256 curEpoch){
        if(time > tgeTime){
            uint256 timeLen = time.sub(tgeTime);
            curEpoch = timeLen.div(epochLenght);
        }
        
    }
    
    
    function addManager(address _mAddr) public onlyOwner{
        manager[_mAddr] = true;
    }
    function delManager(address _mAddr) public onlyOwner{
        manager[_mAddr] = false;
    }
    /*function initPerSeed() internal{
        
    }
    
    function initSeed() internal{
        
    }
    
    function initPrivateRoundOne() internal{
        
    }
    
    function initPrivateRoundTwo() internal{
        
    }
    
    function initLanchPad() internal{
        
    }
    function initAdvisers() internal{
        
    }*/
    
}