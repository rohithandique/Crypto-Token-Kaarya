pragma solidity ^0.6.0;

interface IERC20 {
    
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
}

contract Kaarya is IERC20 {
    
    //setting value of total supply.
    uint public constant _totalSupply = 1000000;
    
    
    string public constant symbol = "KRY";
    string public constant name = "Kaarya Token";
    uint8 public constant decimals = 3;
    
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    constructor() public{
        balances[msg.sender] = _totalSupply;
    }
    
    //returns the total token supply value as an output.
    function totalSupply() override external view returns (uint256) {
        return _totalSupply;
    }

    //takes the address of the account as input.
    //returns the account balance of an account with address 'account'.
    function balanceOf(address account) override external view returns (uint256) {
        return balances[account];
    }
    
    //transfer 'amount' worth of tokens to address 'recipient' and emits the Transfer event.
    //throws error if the function caller's account doesn't have enough balance.
    function transfer(address recipient, uint256 amount) override external returns (bool) {
        require (
            balances[msg.sender] >= amount
            && amount > 0
        );
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    //transfers 'amount' worth of tokens from address 'recipient' to address 'sender' and emits 
    function transferFrom(address sender, address recipient, uint256 amount) override external returns (bool) {
        require(
            allowed[sender][msg.sender] >= amount
            && balances[sender] >= amount
            && amount > 0
        );
        balances[sender] -= amount;
        balances[recipient] += amount;
        allowed[sender][msg.sender] -= amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    //takes in the address of the owner and the spender
    //and gives the number of tokens allowed to be transferred as output.
    function allowance(address owner, address spender) override external view returns (uint256) {
        return allowed[owner][spender];
    }

    //approving someone to transfer funds from owners account upto value 'amount'.
    function approve(address spender, uint256 amount) override external returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
    //produces of the details of the transfer.
    //triggers when tokens are transferred, including zero value transfers.
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    //gives the details of approvals.
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
}