pragma solidity ^0.8.0;

import "./IERC20_2.sol";
import "./IERC20Metadata2.sol";

contract ERC20 is IERC20, IERC20Metadata {
    /* 
        storage
        - balance
        - allowance
        - totalSupply
        - name
        - symbol
    */
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;

    // constructor------------------------
    // set "name" and "symbol" to the storage from the memory

    constructor (string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    // Metadata Interface------------------
    // _name(storage-data) will be returned to the 'memory' releam

    function name() public view override virtual returns(string memory) {
        return _name;
    }
    function symbol() public view override virtual returns (string memory) {
        return _symbol;
    }
    function decimals() public view override virtual returns (uint8) {
        return 18;
    }

    /*
        Interface
        - totalsupply
        - balanceof
        - transfer
        - allowance
        - transferFrom
        - approve
    */

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address owner) public view virtual override returns (uint256) {
        return _balances[owner];
    }

    function transfer(address to, uint256 amount) public virtual override returns(bool) {
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns(uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    // msg.sender = spender
    function transferFrom(address owner, address to, uint256 amount) public virtual override returns (bool) {
        address spender = msg.sender;
        _spendAllowance(owner, spender, amount);
        _transfer(owner, to, amount);
        return true;        
    }
    
    // internal funcs

    // change balances of the two accounts. "from-account" and "to-account"

    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: token transfer from zero address");
        require(to != address(0), "ERC20: token transfer to zero address");

        uint256 currentBalance = _balances[from];
        require(currentBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = currentBalance - amount;
        }
        _balances[to] += amount;
         
         emit Transfer(from, to, amount);
    }

    // transferFrom : 
    //  _spendAllowance ∴ _approve
    //  _transfer

    // change allowance
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from zero address");
        require(spender != address(0), "ERC20: approve to zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    // decrease allowance
    function _spendAllowance(
        address owner,
        address spender,

        // spending amount
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = _allowances[owner][spender];

        // does not update allowance inc case of infinite allowance
        if(currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC19: insufficient allowance");

            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    } 


    /*
        internall hook functions
        - _mint, _burn
            - internal
            - address(0) -> optional account
            - emit transfer event, using zero-address
        - before after token transfer
            - developers are able to extend their token functionalities
    */
    // other functions
}