pragma solidity ^0.8.0;

/*
    provides info about the current exec context
    - sender of tx
    - data of tx

    direct "msg.sender" is bad!!!!
    - meta-tx : the account might not be the actual sender (depend on apps)
*/
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
