pragma solidity ^0.6.0;
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";
/*  Owner               : 0xc6D31a4A6a76F0dd2d0624dd6Aaf5330E0b77c18 (999950+50)
    approve/spender     : 0x2718b0Db393EbA9c4b2c8Cd7DDbA16046ABd1924 (1000)
    Decr.alllow/spender : 0x2718b0Db393EbA9c4b2c8Cd7DDbA16046ABd1924 (100)=900
    
    Incr.allow/spender  : 0x2718b0Db393EbA9c4b2c8Cd7DDbA16046ABd1924 (50)=950
    Transfer/receipient : 0x05ead77c55B041919AFE8f8F2b533c2f5ADf0A67 (50)
    
    Transfer from       : 
    sender              :0xd13cF2217FfA95D5349F538dFA02A1DC803D14FD
    receipient          :0xC9E1F773902D6C11688C0f10AFcb38AA4Bf0a6E8
    
    Allowancee          :
    owner              : 0xD72c93565f54fE0176F6C6537dac43edB0111860
    spender            : 0xd13cF2217FfA95D5349F538dFA02A1DC803D14FD
*/
contract MyCappedToken is ERC20{
    
    address public owner;
    
    
    modifier onlyOwner(){
        require(msg.sender == owner,"Permission Denied: Only owner can access this resource");
        _;
    }
    
    uint256 public cap;
    
    constructor() 
    ERC20("My Capped Token","CTK")
    public{
        owner = msg.sender;
        _setupDecimals(2);
        
        //10000
        uint initialSupply = 10000 * (10 ** uint256(decimals())); 
        
        //cap 
        cap=initialSupply.mul(2);
        
        _mint(owner,initialSupply);
    }
    
    function generateTokens(address account, uint256 amount) public onlyOwner{
        require(account != address(0),"Error: Invalid address");
        require(amount > 0,"Invalid amount");
        require(totalSupply().add(amount)<cap,"Overlimit tokens: Token Generation failed");
        _mint(account,amount);
    }
    
    
}