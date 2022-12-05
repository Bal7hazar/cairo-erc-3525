// SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from openzeppelin.introspection.erc165.library import ERC165
from openzeppelin.token.erc721.enumerable.library import ERC721Enumerable
from openzeppelin.token.erc721.library import ERC721

from carbonable.erc3525.library import ERC3525
from carbonable.erc3525.extensions.slotenumerable.library import ERC3525SlotEnumerable

//
// Constructor
//

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    name: felt, symbol: felt, decimals: felt
) {
    ERC721.initializer(name, symbol);
    ERC721Enumerable.initializer();
    ERC3525.initializer(decimals);
    return ();
}

//
// Getters
//

//
// ERC721
//

@view
func name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (name: felt) {
    return ERC721.name();
}

@view
func symbol{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (symbol: felt) {
    return ERC721.symbol();
}

@view
func tokenURI{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    tokenId: Uint256
) -> (tokenURI: felt) {
    let (tokenURI: felt) = ERC721.token_uri(tokenId);
    return (tokenURI=tokenURI);
}

@view
func balanceOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(owner: felt) -> (
    balance: Uint256
) {
    return ERC721.balance_of(owner);
}

@view
func ownerOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(tokenId: Uint256) -> (
    owner: felt
) {
    return ERC721.owner_of(tokenId);
}

@view
func getApproved{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    tokenId: Uint256
) -> (approved: felt) {
    return ERC721.get_approved(tokenId);
}

@view
func isApprovedForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    owner: felt, operator: felt
) -> (isApproved: felt) {
    let (isApproved: felt) = ERC721.is_approved_for_all(owner, operator);
    return (isApproved=isApproved);
}

//
// ERC165
//

@view
func supportsInterface{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    interfaceId: felt
) -> (success: felt) {
    return ERC165.supports_interface(interfaceId);
}

//
// ERC3525
//

@view
func valueDecimals{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    decimals: felt
) {
    return ERC3525.value_decimals();
}

@view
func balanceOf3525{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    tokenId: Uint256
) -> (balance: Uint256) {
    return ERC3525.balance_of(tokenId);
}

@view
func slotOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(tokenId: Uint256) -> (
    slot: Uint256
) {
    return ERC3525.slot_of(tokenId);
}

@view
func allowance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    tokenId: Uint256, operator: felt
) -> (amount: Uint256) {
    return ERC3525.allowance(tokenId, operator);
}

//
// ERC3525SlotEnumerable
//

func slotCount{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    count: Uint256
) {
    return ERC3525SlotEnumerable.slot_count();
}

func slotByIndex{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    index: Uint256
) -> (slot: Uint256) {
    return ERC3525SlotEnumerable.slot_by_index(index);
}

func tokenSupplyInSlot{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    slot: Uint256
) -> (supply: Uint256) {
    return ERC3525SlotEnumerable.token_supply_in_slot(slot);
}

func tokenInSlotByIndex{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    slot: Uint256, index: Uint256
) -> (tokenId: Uint256) {
    let (tokenId) = ERC3525SlotEnumerable.token_in_slot_by_index(slot, index);
    return (tokenId=tokenId);
}

//
// External functions
//

//
// ERC721
//

@external
func approve{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    to: felt, tokenId: Uint256
) {
    ERC721.approve(to, tokenId);
    return ();
}

@external
func setApprovalForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    operator: felt, approved: felt
) {
    ERC721.set_approval_for_all(operator, approved);
    return ();
}

@external
func transferFrom{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    from_: felt, to: felt, tokenId: Uint256
) {
    ERC721.transfer_from(from_, to, tokenId);
    return ();
}

@external
func safeTransferFrom{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    from_: felt, to: felt, tokenId: Uint256, data_len: felt, data: felt*
) {
    ERC721.safe_transfer_from(from_, to, tokenId, data_len, data);
    return ();
}

//
// ERC3525
//

@external
func approve3525{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    tokenId: Uint256, operator: felt, value: Uint256
) {
    ERC3525.approve(tokenId, operator, value);
    return ();
}

@external
func transferFrom3525{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    fromTokenId: Uint256, toTokenId: Uint256, to: felt, value: Uint256
) -> (newTokenId: Uint256) {
    let (new_token_id: Uint256) = ERC3525.transfer_from(fromTokenId, toTokenId, to, value);
    return (newTokenId=new_token_id);
}

//
// Helpers
//

@external
func mint{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    to: felt, slot: Uint256, value: Uint256
) -> (token_id: Uint256) {
    let (token_id) = ERC3525._mint_new(to, slot, value);
    return (token_id=token_id);
}

@external
func mintValue{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    token_id: Uint256, value: Uint256
) {
    ERC3525._mint_value(token_id, value);
    return ();
}

@external
func burn{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(token_id: Uint256) {
    ERC3525._burn(token_id);
    return ();
}

@external
func burnValue{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    token_id: Uint256, value: Uint256
) {
    ERC3525._burn_value(token_id, value);
    return ();
}

@external
func setTokenURI{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    tokenId: Uint256, tokenURI: felt
) {
    ERC721._set_token_uri(tokenId, tokenURI);
    return ();
}
