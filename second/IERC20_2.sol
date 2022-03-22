pragma solidity ^0.8.0;

/*
ERC20 needs

- functions
    - totalSupply
    - balance
    - transfer
    - allowance
    - approve
    - transferFrom (for delegates)

-event
    - transfer
    - approval
*/

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns(bool);

    // event-name should use Capital letter?
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}