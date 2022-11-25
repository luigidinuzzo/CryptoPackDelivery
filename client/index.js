import Web3 from 'web3';
import configuration from '../build/contracts/PackDeliver.json';
import './node_modules/bootstrap/dist/css/bootstrap.css';

const CONTRACT_ADDRESS =
  configuration.networks['5777'].address;
const CONTRACT_ABI = configuration.abi;

const web3 = new Web3(
  Web3.givenProvider || 'http://127.0.0.1:7545'
);
const contract = new web3.eth.Contract(
  CONTRACT_ABI,
  CONTRACT_ADDRESS
);

let account;

const accountEl = document.getElementById('account');
const flip = document.getElementById('flip');
const create = document.getElementById('create');
const deliver = document.getElementById('deliver');


const createPackForm = async () => {
  const receiver = document.getElementById('receiver').value;
  if(receiver == null){
    alert("Please write receiver address.");
  }
  const num = document.getElementById('num').value;
  if(num == null){
    alert("Please write token's number.");
  }
  const lat = document.getElementById('lat').value;
  if(lat == null){
    alert("Please write the latitude.");
  }
  const long = document.getElementById('long').value;
  if(long == null){
    alert("Please write the longitude.");
  }
  if(receiver != null && num != null && lat != null && long != null){
    contract.methods
      .createPack(receiver, num, lat, long).send({ from: account });
  }
};

const setFlipSaleState = async () => {
  contract.methods.flipSaleState().send({ from: account });
};

const delivery = async () => {
  contract.methods.deliver().send({ from: account });
}; 

const main = async () => {
  const accounts = await web3.eth.requestAccounts();
  account = accounts[0];
  accountEl.innerText = account;
  flip.onclick = setFlipSaleState;
  create.onclick = createPackForm;
  deliver.onclick = delivery;
};

main();