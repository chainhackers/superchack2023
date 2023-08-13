// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./interfaces/IGame.sol";
import "./interfaces/IGameRegistry.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract BattleShip is IGame, Ownable {
    uint256 public number;
    uint256 public digest;
    IGameRegistry public registry;

    constructor(
        IGameRegistry _registry,
        address backend
    ){
        registry = _registry;
        transferOwnership(backend);
    }

    function initGame(uint256 gameId, ZoKratesStructs.Proof calldata proof, uint256[] calldata inputs) external {
        digest = inputs[0];
        emit GameInit(gameId, digest);
    }

    function isValidMove(uint8 coordinate, uint256 gameId) external view returns (bool){
        return coordinate % 5 > 0;
    }

    function move(uint8 coordinate, uint256 gameId) external {
        emit Move(number, coordinate, gameId, msg.sender);
        number++;
    }

    function moveResult(uint256 moveId, uint8 result, uint256 gameId, ZoKratesStructs.Proof calldata proof, uint256[] calldata inputs) external {
        require(digest == inputs[0], "Invalid digest");
        emit MoveResult(moveId, result, gameId);
    }

    function name(uint256 gameId) external view returns (string memory){
        return "BattleShip";
    }

    function image(uint256 gameId) external view returns (string memory){
        return "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Battleship_game_board.svg/1200px-Battleship_game_board.svg.png";
    }
}
