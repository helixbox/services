// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library GPv2Interaction {
    struct Data {
        address target;
        uint256 value;
        bytes callData;
    }
}

library GPv2Trade {
    struct Data {
        uint256 sellTokenIndex;
        uint256 buyTokenIndex;
        address receiver;
        uint256 sellAmount;
        uint256 buyAmount;
        uint32 validTo;
        bytes32 appData;
        uint256 feeAmount;
        uint256 flags;
        uint256 executedAmount;
        bytes signature;
    }
}

library IVault {
    struct BatchSwapStep {
        bytes32 poolId;
        uint256 assetInIndex;
        uint256 assetOutIndex;
        uint256 amount;
        bytes userData;
    }
}

library InteractionLib {
    struct Data {
        address target;
        uint256 value;
        bytes callData;
    }
}

library OrderLib {
    struct CommissionInfo {
        uint256 feePercent;
        address referrerWalletAddress;
        uint256 flag;
    }
}

library SettlementTypes {
    struct SurplusFeeInfo {
        uint256 feePercent;
        address trimReceiver;
        uint256 flag;
    }
}

library TradeLib {
    struct Data {
        uint256 fromTokenAddressIndex;
        uint256 toTokenAddressIndex;
        address owner;
        address receiver;
        uint256 fromTokenAmount;
        uint256 toTokenAmount;
        uint32 validTo;
        bytes32 appData;
        uint256 flags;
        uint256 executedAmount;
        OrderLib.CommissionInfo[] commissionInfos;
        bytes signature;
        SolverFeeInfo solverFeeInfo;
    }
    struct SolverFeeInfo {
        uint256 feePercent;
        address solverAddr;
        uint256 flag;
    }
}

interface GPv2Settlement {
    event CommissionFeePaid(bytes orderUID, address indexed token, address indexed referral, uint256 feePercent, uint256 feeAmount, uint256 flag);
    event Interaction(address indexed target, uint256 value, bytes4 selector);
    event OrderInvalidated(address indexed owner, bytes orderUid);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event PreSignature(address indexed owner, bytes orderUid, bool signed);
    event Settlement(address indexed solver, uint256 indexed settleId);
    event SolverAdded(address solver);
    event SolverFeePaid(bytes orderUID, address indexed token, address indexed solverAddr, uint256 feePercent, uint256 feeAmount, uint256 flag);
    event SolverRemoved(address solver);
    event SurplusFeePaid(address indexed token, address indexed trimAddress, uint256 feePercent, uint256 feeAmount, uint256 flag);
    event SurplusFeeUserPaid(bytes orderUID, address indexed token, address indexed userAddress, uint256 feeAmount);
    event Trade(address indexed owner, address indexed fromTokenAddress, address indexed toTokenAddress, uint256 fromTokenAmount, uint256 toTokenAmount, bytes orderUid);
    event Settlement(address indexed solver);
    event Trade(address indexed owner, address sellToken, address buyToken, uint256 sellAmount, uint256 buyAmount, uint256 feeAmount, bytes orderUid);


    function freeFilledAmountStorage(bytes[] memory orderUids) external;
    function freePreSignatureStorage(bytes[] memory orderUids) external;
    function settle(address[] memory tokens, uint256[] memory clearingPrices, GPv2Trade.Data[] memory trades, GPv2Interaction.Data[][3] memory interactions) external;
    function swap(IVault.BatchSwapStep[] memory swaps, address[] memory tokens, GPv2Trade.Data memory trade) external;
    function vault() external view returns (address);
    function vaultRelayer() external view returns (address);

    receive() external payable;

    function addSolver(address solver) external;
    function domainSeparator() external view returns (bytes32);
    function filledAmount(bytes memory) external view returns (uint256);
    function getStorageAt(uint256 offset, uint256 length) external view returns (bytes memory);
    function invalidateOrder(bytes memory orderUid) external;
    function isSolver(address prospectiveSolver) external view returns (bool);
    function owner() external view returns (address);
    function preSignature(bytes memory) external view returns (uint256);
    function removeSolver(address solver) external;
    function renounceOwnership() external;
    function setPreSignature(bytes memory orderUid, bool signed) external;
    function settleOKX(uint256 settleId, address[] memory tokens, uint256[] memory clearingPrices, TradeLib.Data[] memory trades, InteractionLib.Data[][3] memory interactions, SettlementTypes.SurplusFeeInfo memory surplusFeeInfo) external;
    function simulateDelegatecall(address targetContract, bytes memory calldataPayload) external returns (bytes memory response);
    function simulateDelegatecallInternal(address targetContract, bytes memory calldataPayload) external returns (bytes memory response);
    function tokenApproveProxy() external view returns (address);
    function transferOwnership(address newOwner) external;

	function authenticator() external view returns (address);
}
