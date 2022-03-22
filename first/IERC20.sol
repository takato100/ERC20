pragma solidity ^0.8.0;

/*
Interface!!
    - <-> ABI
    - no exec part
    - 簡単な設計図みたいな感じ？
*/

interface IERC20 {

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    // may use the msg.sender ??
    function transfer(address to, uint256 amount) external returns (bool);

    // balance for an account(spender) in a specific contract(owner)
    function allowance(address owner, address spender) external view returns (uint256);

    function approve (address owner, uint256 amount) external returns (bool);

    function transeferFrom(
        address from,
        address to,
        uint256 amount
    )  external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

}