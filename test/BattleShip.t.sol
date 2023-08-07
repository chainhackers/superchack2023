// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {IGame} from "../src/interfaces/IGame.sol";
import {BattleShip} from "../src/BattleShip.sol";

contract BattleShipTest is Test {
    BattleShip public battleShip;

    function setUp() public {
        battleShip = new BattleShip();
    }

    function testIsValidMove(uint8 x, uint256 gameId) public {
        assertTrue(battleShip.isValidMove(1, gameId));
    }

    function testMove(uint8 x, uint256 gameId) public {
        battleShip.move(x, gameId);
        assertEq(battleShip.number(), 1);
    }

    function testMoveTwice(uint8 x, uint256 gameId) public {
        battleShip.move(x, gameId);
        battleShip.move(x, gameId);
        assertEq(battleShip.number(), 2);
    }

    event MoveResult(uint256 id, uint8 result, uint256 indexed gameId);

    function testMoveResult(uint256 moveId, uint8 result, uint256 gameId) public {
        vm.expectEmit(address(battleShip));
        emit MoveResult(moveId, result, gameId);
        battleShip.moveResult(moveId, result, gameId);
    }
}
