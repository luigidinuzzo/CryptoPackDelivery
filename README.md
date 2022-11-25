# CryptoPackDelivery
_CryptoPackDelivery_ is an Ethereum's Solidity-written dApp simulating the delivering of packages, each parcel is treated as an _NFT_, in fact at the time of creation it is placed in the container and mined, while at the end of the delivery, the ownership of the _NFT_ is automatically transferred to the receiver address entered in the initial form.

<p align="center">
  <img src="https://github.com/luigidinuzzo/CryptoPackDelivery/blob/main/Presentazione/img/webApp.png" alt="webApp"/>
</p>


## Download
Download the zip file from github or clone it from the command line:

```
git clone https://github.com/luigidinuzzo/CryptoPackDelivery.git
```

## Technology stack
> + [Solidity](https://soliditylang.org) and [Remix IDE](https://remix.ethereum.org) for writing smart contracts;
> + [Truffle](https://trufflesuite.com/truffle) for deploying contracts to the blockchain;
> + [Ganache](https://www.trufflesuite.com/ganache) as testnet;
> + Node.js, [Npm](https://nodejs.org/en) and [Boostrap](https://getbootstrap.com) for frontend;
> + [Metamask](https://metamask.io) Account for testing the transactions;


## Set up the development environment
### Necessary programs and plugins

> + Clone this repository;
> + Install Node.js, [Npm](https://nodejs.org/en) and [Boostrap](https://getbootstrap.com);
> + Install Truffle: ```npm install -g truffle```;
> + Download [Ganache](https://www.trufflesuite.com/ganache);

### Set up the project
> + Start Truffle: ```truffle init```;
> + Create a Ganache's workspace configured with our [_truffle-config.js_](https://github.com/luigidinuzzo/CryptoPackDelivery/blob/main/truffle-config.js) file;
> + Migrate Truffle: ```truffle migrate``` and it will migrate all the file _.js_ in the Migrations folder;
> + Create a [Metamask](https://metamask.io) Account for testing the transactions;
> + Add a localhost newtwork in your Metamask Account specifing the same URL as Ganache's;
> + Go to Metamask and import an Account using the address and a private keys from a Ganache's Account;
> + Start th project using npm and the localhost: ```npm run start```;
> + Have fun! 




## Folders

> + [Presentazione][lk_pre]: presentation of the project and images used;
> + [Build][lk_bui]: json files ;
> + [Client][lk_clt]:  for the Website's GUI, JS & HTML;
> + [Contracts][lk_con]: all about solidity's contracts;
> + [Migrations][lk_mig]: all about migrations for Ganache;

[lk_pre]: https://github.com/luigidinuzzo/CryptoPackDelivery/tree/main/Presentazione	"Presentazione"
[lk_bui]: https://github.com/luigidinuzzo/CryptoPackDelivery/tree/main/build "Build"
[lk_clt]: https://github.com/luigidinuzzo/CryptoPackDelivery/tree/main/client "Client"
[lk_con]: https://github.com/luigidinuzzo/CryptoPackDelivery/tree/main/contracts "Contracts"
[lk_mig]: https://github.com/luigidinuzzo/CryptoPackDelivery/tree/main/migrations "Migrations"



## Authors

+ Luigi di Nuzzo @[luigidinuzzo](https://github.com/luigidinuzzo)
+ Filippo Veronesi @[filippoveronesi](https://github.com/filippoveronesi)
