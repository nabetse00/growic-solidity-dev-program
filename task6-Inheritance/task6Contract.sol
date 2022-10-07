pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// Contract
contract Task6Contract is ERC20 {
    constructor() payable ERC20("Nabetse TOKEN", "NAB") {
        // fixed supply using internal _mint function
        // here 9900 NABs initial supply 
        _mint(msg.sender, 9900);
    }

    // no decimals
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    // to support receiving ETH by default
    receive() external payable {}

    fallback() external payable {}
}

// Contract 0xB9d472fEB6FF180434F3D8b74aA3d79817DdC1C9