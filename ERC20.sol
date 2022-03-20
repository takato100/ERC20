pragma solidity ^0.8.0;

// import "./IERC20.sol";
// import "./extensions/IERC20Metadata.sol";
// import "../../utils/Context.sol";

contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowance;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;

   constructor(string memory name_, string memory sysmbol_) {
       _name = name_;
       _symbol = symbol_;
   }

   // what is virtual?? -> this func can be overrided!!
   // override -> this func was made by overriding other func
   function name() public view virtual override returns (string memory) {
       return _name;
   }

   function symbol() public view virtual override returns (string memory) {
       return _symbol;
   }

   // why not memory? compared from those 2 above?
   function decimals() public view virtual override returns (uint8) {
       return 18;
   }

   // interface --------------------------------

   function totalSupply() public view virtual override returns (uint256) {
       return _totalSupply;
   }

   function balanceOf(address account) public view virtual override returns (uint256) {
       return _balance[account];
   }

   // why dont use msg.sender directly?
   function transfer(address to, uint256 amount) public virtual override returns (bool) {
       address owner = _msgSender();
   }

   function allowance(address owner, address spender) public virtual override returns (uint256) {
       return _allowance[owner][spender];
   }

   // for the owners, to approve their tokens
   function approve(address spender, uint256 amount) public virtual override returs (bool) {
       address owner = _msgSender();
       _approve(owner, spender, amount);
       return true;
   }

   // for the "spender", who were delegated the token from the owner
   function transferFrom(
       address from,
       address to,
       uint256 amount
   ) public virtual override returns (bool) {
       address spender = _msgSender();
       _approve(from, spender, amount);
       _transfer(from, to, amount);
       return true;
   }

   // interface fin ------

   function increaseAllowance(address spender, uint256 addedValue) public virtual override returns (bool) {
       address owner = _msgSender();
       _approve(owner, spender, addedValue + allowance(owner, spender);
       return true;
   }

    function decreaseAllowance(address spender, uint256 substractedValue) public virtual override retuns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        reqire(currentAllowance >= substractedAllowance, "ERC20: decreased allowance below zero");
        unchecked {   
            _approve(owner, spender, currentAllowance - substractedValue);
        }
        return true;
    }

   // internal funcs -----------------------------------------

   function _transfer(
       address from,
       address to,
       uint256 amount
   ) internal virtual {
       require(from != address(0), "ERC20 transfer from the zero addr");
       require(to != address(0), "ERC20 transfer to the zero addr");

       _beforeTokenTransfer(from, to, amount);
       
       uint fromBalance = _balances[from];
       require(fromBalance >= amount, "ERC20 transfer amount exeeds balance");

       // whats uncheked?
       unchecked {
           _balances[from] = fromBalance - amount; 
       }

       _balaces[to] += amount;

       // from IERC.20
       emit Transfer(from, to, amount);

       _afterTokenTransfer(from, to, amount);
   }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");
        
        _beforeTokenTransfer(address(0), account, amount);


        // private var _totalSupply
        _totalSupply += amount;

        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

"
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

    //function _spendAllowance(
 
   //------------------------------



    
    //hook, called from any token transfers (mint burn included)

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual{}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    //--------------------------------------

}
