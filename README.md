# armor-analytics

## Dashboard Ouput

- https://duneanalytics.com/armor/Armor-Testground
    - Proposal for new main Armor dashboard
    - includes key stats and charts
    - awaiting team feedback

- https://duneanalytics.com/masquot/Armor-Testground
    - arCore stats based of python script output to SQL
    - arNFT staking stats Jan + Feb 2021
    - arNFT cover stats and totals

- https://duneanalytics.com/masquot/Armor-and-Nexus-Mutual-Testground
    - stats and charts related to NXM staking
    - arNXM, wNXM token supply stats

- https://duneanalytics.com/masquot/Liquidity-Providers-Testground
    - Liquidity provider stats Uniswap for ARMOR pairs
    - Work halted because of lower priority


## Code Ouput

Most base queries as well as the python scripts are available in this repository.


## Work Items

- [x] Total arNFT staked on arCore (by coverage, and by purchase cost)
- [x] NXM staking rewards received per week
- [x] arNXM:NXM ratio
- [ ] LOWER PRIORITY trade volume and liquidity of all Armor and arNXM LPs
- [x] NXM staked per contract
- [x] NXM waiting to be unstaked from each contract
- [x] Unlock schedule (30 days after unstaking) of the NXM (how much NXM will be unlocking when, from which contract)
- [x] Would also like to see ETH versions of the charts we already have in dune
- [x] we will need a stats dashboard for arCore utilization as well: how much cover available for each protocol; how much is being utilized etc 


## Review Data Quality Item list

I went over all contracts on Etherscan, and made sample tests in Dune Analytics. The results of this work are documented here in the files 'armor-contracts-overview.md' and 'armor-contracts-dune-tests.md'.
Here is a simple Dune test dashboard so you can get an idea of my work:
https://duneanalytics.com/masquot/Armor-Testground

The biggest challenge in creating Dune Analytics dashboard is that the data in Dune is incomplete. There are two reasons why this is the case:
1. Armor's contract development style involves frequent contract updates with ABI changes. One example is the following chart [Armor.Fi wNXM locked in arNXM vault](https://duneanalytics.com/queries/18211/36837) chart. The data stops on Feb 12th. What happened on Feb 12th? A new implementation of the smart contract was deployed and the signature of the `Deposit` event changed from
   * `emit Deposit(msg.sender, _wAmount, block.timestamp)`
   to
   *  `emit Deposit(msg.sender, _nAmount, arAmount, block.timestamp);`
  
    The data tables of Dune Analytics however rely on these signatures remaining unchanged.

2. The ABIs for the following contracts are not verified on Etherscan:
	- 0xCA3734d4D202D68932944730D8b08E054589574D
	- 0x0935Dcaf018f546Abc857580c4b8233acf11B6E2
	Even if they are not the latest implementations, we need all contracts verified for Dune Analytics to work.
