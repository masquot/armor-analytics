# armor-analytics

## Work Summary

I went over all contracts on Etherscan, and made sample tests in Dune Analytics. The results of this work are documented here in the files 'armor-contracts-overview.md' and 'armor-contracts-dune-tests.md'.
You can also find some of my SQL queries in this repo. As you can see, I use `WITH` statements to make the SQL more readable and maintainable.
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
